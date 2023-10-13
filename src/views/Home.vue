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
          <v-col
            v-for="n in 24"
            :key="n"
            cols="12"
            md="4"
          >
            <v-card height="100"></v-card>
          </v-col>
          <!-- <v-btn color="">asdad</v-btn> -->
        </v-row>
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
