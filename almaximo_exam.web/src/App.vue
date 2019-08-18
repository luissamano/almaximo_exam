<template>
  <div id="app">
    <v-app id="inspire">
      
      <!--- NAVIGATION DRAWER --->
      <v-navigation-drawer fixed :clipped="$vuetify.breakpoint.mdAndUp" app v-model="drawer">
        <v-list dense>
          
          <template>
            <v-list-tile :to="{ name: 'productos' }">
              <v-list-tile-action>
                <v-icon>dashboard</v-icon>
              </v-list-tile-action>
              <v-list-tile-title>Productos</v-list-tile-title>
            </v-list-tile>
          </template>

        </v-list>
      </v-navigation-drawer>

      <!--- TOOLBAR --->
      <v-toolbar color="blue darken-3" dark app :clipped-left="$vuetify.breakpoint.mdAndUp" fixed>
        <v-toolbar-title style="width: 300px" class="ml-0 pl-3">
          <v-toolbar-side-icon @click.stop="drawer = !drawer"></v-toolbar-side-icon>
          <span class="hidden-sm-and-down">Punto de venta</span>
        </v-toolbar-title>

        <v-spacer></v-spacer>
      </v-toolbar>

      <!--- CUERPO CONTENT --->
      <v-content>
        <v-container fluid fill-height>
          <v-slide-y-transition mode="out-in">
            <router-view />
          </v-slide-y-transition>
        </v-container>
      </v-content>

    </v-app>
  </div>
</template>

<script>
export default {
  name: "App",
  
  data() {
    return {
      drawer: null
    };
  }
};
</script>
