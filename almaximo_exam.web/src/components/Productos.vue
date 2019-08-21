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

        <v-dialog v-model="dialog" persistent max-width="800px">
          <template v-slot:activator="{ on }">
            <v-btn color="pink" dark v-on="on">Agregar un producto</v-btn>
          </template>
          <v-card>
            <v-toolbar>
              <v-btn icon @click="dialog = false">
                <v-icon>close</v-icon>
              </v-btn>
              <v-card-title>
                <span class="headline">Agregar un producto</span>
              </v-card-title>
              <v-spacer></v-spacer>
            </v-toolbar>

            <!-- Modal Nuevo producto -->
            <v-layout column>
              <v-form ref="form" v-model="valid" lazy-validation>
                <v-container grid-list-md text-center>
                  <v-layout wrap>
                    <v-flex xs12 md6>
                      <v-text-field
                        v-model="clave"
                        label="Clave"
                        :counter="50"
                        :rules="[v => !!v || 'Campo requerido']"
                        required
                      ></v-text-field>
                      <v-text-field
                        v-model="nombre"
                        label="Nombre"
                        :counter="50"
                        :rules="[v => !!v || 'Campo requerido']"
                        required
                      ></v-text-field>
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
                      <v-text-field
                        type="number"
                        v-model="costo"
                        label="Costo"
                        :rules="[v => !!v || 'Campo requerido']"
                        required
                      ></v-text-field>
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

                    <v-card-actions>
                      <v-spacer></v-spacer>
                      <v-flex xs12>
                        <v-btn @click="validate()" class="mr-4">Registar</v-btn>
                        <v-btn @click="limpiar()">Limpiar</v-btn>
                      </v-flex>
                    </v-card-actions>

                    <v-spacer></v-spacer>
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
                              <!--<v-icon small @click="editItem(props.item)">edit</v-icon>-->
                              <v-icon small @click="showDeleteItem(props.item)">delete</v-icon>
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

            <!-- Modaal Eliminar de pre-registro -->
            <v-dialog v-model="dialogEliminar" persistent max-width="290">
              <v-card>
                <v-card-title class="headline">Confirme la accion</v-card-title>
                <v-card-text>
                  Esta a punto de eliminar el elemento.
                  ¿Esta seguro de hacerlo?
                </v-card-text>
                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn text @click="eliminarCache()">Cancelar</v-btn>
                  <v-btn text @click="deleteItem()">Confirmar</v-btn>
                </v-card-actions>
              </v-card>
            </v-dialog>
          </v-card>
        </v-dialog>
      </v-toolbar>

      <!-- Tabla productos -->
      <v-data-table :headers="headers" :items="productos" :search="search" class="elevation-1">
        <template v-slot:items="props">
          <td>{{ props.item.clave }}</td>
          <td class="text-xs-start">{{ props.item.nombre }}</td>
          <td class="text-xs-start">{{ props.item.tipo_producto }}</td>
          <td class="text-xs-start">{{ props.item.costo }}</td>
          <td class="text-xs-start">{{ props.item.estatus }}</td>
          <td class="text-xs-start">{{ props.item.proveedor }}</td>
          <v-spacer></v-spacer>
          <!-- 
          <td class="justify-center layout px-0">
            <v-icon small class="mr-2" @click="validateEdit(props.item)">edit</v-icon>
            <v-icon small @click="deleteItemDb(props.item)">delete</v-icon>
          </td>
          -->
        </template>
        <template v-slot:no-data>
          <v-btn color="primary" @click="create()">Reset</v-btn>
        </template>
      </v-data-table>


      <!-- Snackbar Error -->
      <v-snackbar
        v-model="snackbar_error"
        :bottom="y === 'bottom'"
        :color="color"
        :timeout="timeout"
      >
        {{ text_validation }}
        <v-btn dark text @click="snackbar_error = false">Ok</v-btn>
      </v-snackbar>

      <!-- Snackbar Success -->
      <v-snackbar
        v-model="snackbar_success"
        :bottom="y === 'bottom'"
        :color="color1"
        :timeout="timeout"
      >
        {{ text_snackbar }}
        <v-btn dark text @click="snackbar_success = false">Ok</v-btn>
      </v-snackbar>
    </v-flex>
  </v-layout>
</template>


<script>
import axios from "axios";

export default {
  data() {
    return {
      URLbase: "http://localhost:5001/",
      mode: "",
      snackbar_error: false,
      snackbar_success: false,
      text_validation: "Hay campos vacios",
      text_snackbar: "Datos guardados con exito",
      timeout: 6000,
      color: "error",
      color1: "success",
      x: "",
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
      itemTMPdelete: null,

      // Productos
      preProductos: [],
      productos: [],

      // Selects
      proveedores: [],
      type_prod: [],
      status: ["Activo", "No Activo"],

      dialog: false,
      dialogEditar: false,
      dialogEliminar: false,
      headers: [
        { text: "Clave", value: "clave" },
        { text: "Nombre", value: "nombre" },
        { text: "Tipo de producto", value: "tipo_producto" },
        { text: "Costo", value: "costo" },
        { text: "Estatus", value: "estatus" },
        { text: "Proveedor", value: "proveedor" }
      ],
      search: "",
      editedIndex: -1,
      editedItem: {
        clave: "",
        nombre: "",
        tipo: "",
        costo: 0.0,
        estatus: "",
        proveedor: ""
      }
    };
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
    validate() {
      if (this.$refs.form.validate()) {
        console.log("Validate, Los campos requeridos estan completos");
        this.registar();
      } else {
        this.snackbar_error = true;
        console.log("Validate, Los campos del formulario estan vacios");
      }
    },

    listar() {
      let me = this;

      axios
        .get(`${me.URLbase}api/productos`)
        .then(function(response) {
          console.log(response);
          me.productos = response.data;
        })
        .catch(function(error) {
          console.log(error);
        });

      axios
        .get(`${me.URLbase}api/tiipo`)
        .then(function(response1) {
          me.type_prod = response1.data;
        })
        .catch(function(error1) {
          console.log(error1);
        });

      axios
        .get(`${me.URLbase}api/proveedor`)
        .then(function(response2) {
          me.proveedores = response2.data;
        })
        .catch(function(error2) {
          console.log(error2);
        });
    },

    registar() {
      let me = this;

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
      this.limpiar();
      this.$refs.form.resetValidation();
      console.log("Se agrego el producto: " + item.clave);
    },

    showDeleteItem(item) {
      this.dialogEliminar = true;
      this.itemTMPdelete = item;
    },

    eliminarCache() {
      this.dialogEliminar = false;
      this.itemTMPdelete = null;
    },

    editItem(item) {
      console.log("editar");
      //this.editedIndex = this.preProductos.indexOf(item);
      //this.editedItem = Object.assign({}, item);
      //this.dialogEditar = true;
    },

    deleteItem() {
      const index = this.preProductos.indexOf(this.itemTMPdelete);
      this.preProductos.splice(index, 1);

      console.log("Se quito el producto: " + this.itemTMPdelete.clave);
      this.dialogEliminar = false;
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

      me.dialog = false;
      axios
        .post(`${me.URLbase}api/productos`, me.preProductos)
        .then(async function(response3) {
          console.log(response3);
          me.snackbar_success = true;
          me.limpiar();
        })
        .catch(async function(error3) {
          console.log("Nada: " + error3);
        });
      this.close();
    },

    limpiar() {
      let me = this;

      me.clave = "";
      me.nombre = "";
      me.tipo = "";
      me.estatus = "";
      me.costo = 0.0;
      me.proveedor = "";

      this.$refs.form.resetValidation();
    }
  }
};
</script>
 