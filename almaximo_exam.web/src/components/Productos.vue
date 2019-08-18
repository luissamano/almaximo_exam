<template>
  <v-layout align-start>
    <v-flex>
      <v-toolbar flat color="blue-grey lighten-5">
        <v-toolbar-title>Todos los Productos</v-toolbar-title>
        <v-divider class="mx-2" inset vertical></v-divider>

        <v-spacer></v-spacer>
        <v-text-field
          class="text-xs-center"
          v-model="search"
          append-icon="search"
          label="Buscar producto"
          single-line
          hide-details
        ></v-text-field>
        <v-spacer></v-spacer>

        <v-dialog v-model="dialog" fullscreen hide-overlay transition="dialog-bottom-transition">
          <template v-slot:activator="{ on }">
            <v-btn color="pink" dark v-on="on">Agregar un producto</v-btn>
          </template>
          <v-card>
            <v-toolbar flat color="blue darken-3">
              <v-btn icon dark @click="dialog = false">
                <v-icon>close</v-icon>
              </v-btn>
              <v-toolbar-title style="width: 300px" class="ml-0 pl-3">
                <span class="hidden-sm-and-down">Agregar un nuevo producto</span>
              </v-toolbar-title>
              <v-spacer></v-spacer>
            </v-toolbar>

            <v-layout column>
              <v-form ref="form" v-model="valid" lazy-validation >
                <v-container grid-list-md text-center>
                  <v-layout wrap>
                    <v-flex xs12 md6>
                      <v-text-field v-model="clave" label="Clave" :counter="50"
                                    :rules="[v => !!v || 'Campo requerido']" required></v-text-field>
                      <v-text-field v-model="nombre" label="Nombre" :counter="50"
                                    :rules="[v => !!v || 'Campo requerido']" required></v-text-field>
                    </v-flex>

                    <v-flex xs12 md6>
                      <v-select
                        v-model="tipo"
                        :items="type_prod"
                        :rules="[v => !!v || 'Campo requerido']"
                        item-text="nombre"
                        label="Tipo de producto"
                        persistent-hint
                        return-object
                        single-line
                      ></v-select>
                      <v-text-field type="number" v-model="costo" label="Costo"
                                    :rules="[v => !!v || 'Campo requerido']" required></v-text-field>
                    </v-flex>

                    <v-flex xs12 md6>
                      <v-select
                        v-model="proveedor"
                        :items="proveedores"
                        item-text="nombre"
                        :rules="[v => !!v || 'Campo requerido']"
                        label="Proveedor"
                        persistent-hint
                        return-object
                        single-line
                      ></v-select>
                      <v-layout wrap justify-space-around>
                        <v-checkbox v-model="estatus" label="Activo"></v-checkbox>
                      </v-layout>
                    </v-flex>

                    <v-flex xs12>
                      <v-btn @click="registar()" class="mr-4">Registar</v-btn>
                      <v-btn @click="limpiar()" >Limpiar</v-btn>
                    </v-flex>

                    <v-flex xs12 md12>
                      <v-data-table hide-default-footer :headers="headers" :items="preProductos">
                        <template v-slot:items="props">
                          <td>{{ props.item.clave }}</td>
                          <td class="text-xs-start">{{ props.item.nombre }}</td>
                          <td class="text-xs-start">{{ props.item.tipo_producto }}</td>
                          <td class="text-xs-start">{{ props.item.costo }}</td>
                          <td class="text-xs-start">{{ props.item.estatus }}</td>
                          <td class="text-xs-start">{{ props.item.proveedor }}</td>
                          <v-spacer></v-spacer>
                          <td class="justify-center layout px-0">
                            <v-icon small class="mr-2" @click="editItem(props.item)">edit</v-icon>
                            <v-icon small @click="deleteItem(props.item)">delete</v-icon>
                          </td>
                        </template>
                        <template v-slot:no-data>
                          <span></span>
                        </template>
                      </v-data-table>
                    </v-flex>
                    <v-flex xs12>
                      <v-btn @click="save()" class="mr-4">Guardar</v-btn>
                    </v-flex>
                  </v-layout>
                </v-container>
              </v-form>
            </v-layout>
          </v-card>
        </v-dialog>
      </v-toolbar>

      <v-snackbar
        v-model="snackbar"
        :bottom="y === 'bottom'"
        :color="color"
        :left="x === 'left'"
        :multi-line="mode === 'multi-line'"
        :right="x === 'right'"
        :timeout="timeout"
        :top="y === 'top'"
        :vertical="mode === 'vertical'"
      >
        {{ text_validation }}
        <v-btn dark text @click="snackbar = false">Cerrar</v-btn>
      </v-snackbar>

      <v-data-table :headers="headers" :items="productos" :search="search" class="elevation-1">
        <template v-slot:items="props">
          <td>{{ props.item.clave }}</td>
          <td class="text-xs-start">{{ props.item.nombre }}</td>
          <td class="text-xs-start">{{ props.item.tipo_producto }}</td>
          <td class="text-xs-start">{{ props.item.costo }}</td>
          <td class="text-xs-start">{{ props.item.estatus }}</td>
          <td class="text-xs-start">{{ props.item.proveedor }}</td>
          <v-spacer></v-spacer>
          <td class="justify-center layout px-0">
            <v-icon small class="mr-2" @click="editItemDb(props.item)">edit</v-icon>
            <v-icon small @click="deleteItemDb(props.item)">delete</v-icon>
          </td>
        </template>
        <template v-slot:no-data>
          <v-btn color="primary">Reset</v-btn>
        </template>
      </v-data-table>
    </v-flex>
  </v-layout>
</template>


<script>
import axios from "axios";

export default {
  data() {
    return {
      mode: "",
      snackbar: false,
      text_validation: "Hay campos vacios",
      timeout: 6000,
      x: null,
      y: "top",

      // Valores
      clave: "",
      nombre: "",
      tipo: "",
      costo: 0,
      estatus: true,
      proveedor: "",

      valid: true,
      select: { nombre: "" },
      checkbox: null,

      // Productos
      preProductos: [],
      productos: [],

      // Selects
      proveedores: [],
      type_prod: [],

      dialog: false,
      headers: [
        { text: "Clave", value: "clave" },
        { text: "Nombre", value: "nombre" },
        { text: "Tipo de producto", value: "tipo_producto" },
        { text: "Costo", value: "costo" },
        { text: "Estatus", value: "estatus" },
        { text: "Proveedor", value: "proveedor" }
      ],
      search: "",
      editedIndex: -1
    };
  },
  computed: {
    formTitle() {
      return this.editedIndex === -1 ? "Nuevo Producto" : "Editar Producto";
    }
  },
  watch: {
    dialog(val) {
      val || this.close();
    }
  },
  created() {
    this.listar();
  },
  methods: {
    
    validate(){
      if (this.$refs.form.validate()){
        this.snackbar = true;
        console.log("Validate")
      }
    },
    listar() {
      var URLbase = "http://192.168.1.69:5001/"  
      let me = this;
      axios
        .get(`${URLbase}api/productos`)
        .then(function(response) {
          console.log(response);
          me.productos = response.data;
        })
        .catch(function(error) {
          console.log(error);
        });

      axios
        .get(`${URLbase}api/tiipo`)
        .then(function(response1) {
          me.type_prod = response1.data;
        })
        .catch(function(error1) {
          console.log(error1);
        });

      axios
        .get(`${URLbase}api/proveedor`)
        .then(function(response2) {
          me.proveedores = response2.data;
        })
        .catch(function(error2) {
          console.log(error2);
        });
    },

    registar() {
      let me = this;
      if (me.clave === "" && me.nombre === "" && me.tipo_producto === "" && me.costo === "" && me.proveedor === "") {
        this.snackbar = true
      }
      var act = "";
      if (me.estatus == true) {
        act = "Activo";
      } else {
        act = "No activo";
      }

      var item = {
        clave: me.clave,
        nombre: me.nombre,
        tipo_producto: me.tipo.nombre,
        costo: me.costo,
        estatus: act,
        proveedor: me.proveedor.nombre
      };

      me.preProductos.push(item);

      console.log(me.preProductos);
    },
    editItemDb(item) {},
    deleteItemDb(item) {
      var index = this.productos.indexOf(item);
      confirm("Estas seguro de eliminar el producto del catálogo?")
      axios
      .delete(`${URLbase}/api/producto/delete`,  index)
      .then(function(response) {
        
      })
      .catch(function(error) {
        
      })
    },
    editItem(item) {},
    deleteItem(item) {
      const index = this.preProductos.indexOf(item);
      confirm("Estas seguro de eliminar el producto del catálogo?") &&
        this.preProductos.splice(index, 1);
    },
    close() {
      this.dialog = false;
      setTimeout(() => {
        this.editedItem = Object.assign({}, this.defaultItem);
        this.editedIndex = -1;
      }, 300);
    },
    save() {
      let me = this;
      
      validate();
      axios.put(`${URLbase}api/productos`, me.preProductos)
      .then(function(response3){
        console.log(response);
        limpiar();
      })
      .catch(function(error3){
        console.log("Nada");
        console.log(error);
      })
      this.close();
    },
    limpiar () {
      this.$refs.form.resetValidation();
      let me = this;

      me.clave = "";
      me.nombre = "";
      me.tipo = "";
      me.estatus = "";
      me.costo = 0.0;
      me.proveedor = "";      

      me.preProductos = [];
    }
  }
};
</script>
 