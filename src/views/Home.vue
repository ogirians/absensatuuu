<template>
  <v-app id="inspire">
    <v-navigation-drawer v-model="drawer">
      <v-list>
        <v-list-item
          v-for="[icon, text] in links"
          :key="icon"
          :prepend-icon="icon"
          :title="text"
          link
        ></v-list-item>
      </v-list>
    </v-navigation-drawer>

    <v-app-bar>
      <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>

      <v-app-bar-title>Absensatuu</v-app-bar-title>
    </v-app-bar>

    <v-main>
      <v-container class="mt-5">
        <v-row>
          <template v-for="n in 4" :key="n">
            <v-col
              class="mt-2"
              cols="12"
            >
              <strong>Category {{ n }}</strong>
            </v-col>

            <v-col
              v-for="j in 8"
              :key="`${n}${j}`"
              cols="6"
              md="2"
            >
              <v-sheet height="150" elevation="4">
                <v-container>
                  snack... 
                  <v-divider :thickness="4"></v-divider>
                  ceritanya ada foto...

                </v-container>
              </v-sheet>
            </v-col>
          </template>
        </v-row>
        <!-- <v-row>
          <v-col
            v-for="n in 24"
            :key="n"
            cols="12"
            md="4"
          >
            <v-card>
              <v-card-title class="bg-primary">Snack</v-card-title>
              <v-divider></v-divider>
              <v-card-item>
                ceritanya gambar ..
              </v-card-item>
              <v-divider></v-divider>
              <v-card-actions class="flex justify-end">
                 stok : 99
              </v-card-actions>
            </v-card>
          </v-col>
        </v-row> -->
      </v-container>
    </v-main>
  </v-app>
</template>

<script setup>
  import { ref } from 'vue'

  const drawer = ref(null)

  const links = [
    ['mdi-inbox-arrow-down', 'Menu'],
    ['mdi-send', 'Pre Order'],
    ['mdi-delete', 'Trash'],
    ['mdi-alert-octagon', 'Spam'],
  ]
</script>

<!-- <script>
  export default {
    data: () => ({ drawer: null }),
  }
</script> -->
