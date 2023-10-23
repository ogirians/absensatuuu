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
        <!-- <v-row> -->
          <!-- add category -->
          <!-- <template v-for="n in 4" :key="n">
            <v-col
              class="mt-2"
              cols="12"
            > -->
              <!-- <strong>Category {{ n }}</strong> -->
            <!-- </v-col> -->

            <!-- <v-col
              v-for="jajan in jajanan "
              :key="jajan.id"
              cols="6"
              md="2"
            >
              <v-sheet height="200" elevation="4">
                <v-container>
                  {{ jajan.nama }} 
                  <v-divider :thickness="2"></v-divider>
                  ceritanya ada foto...
                  <v-divider></v-divider>
                  stock : {{ jajan.qty }}
                </v-container>
              </v-sheet>
            </v-col> -->
          <!-- </template> -->
        <!-- </v-row> -->
        <v-row>
          <v-col
            v-for="jajan in jajanan_ready"
            :key="jajan.id"
            cols="6"
            md="3"
          >
            <v-card>
              <v-card-title class="bg-primary">{{jajan.nama}}</v-card-title>
              <v-divider></v-divider>
              <v-card-item>
                <v-img
                  height="150" src="@/assets/jajan_default.png" 
                /> 
              </v-card-item>
              <v-divider></v-divider>
              <v-card-actions class="flex justify-end">
                 <b>
                   stock : {{ jajan.qty }}
                 </b>
              </v-card-actions>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
    </v-main>
  </v-app>
</template>

<script setup>
import { computed } from 'vue';
import { ref, onMounted } from 'vue'

  const drawer = ref(null);
  const jajanan = ref('');

  const links = [
    ['mdi-inbox-arrow-down', 'Stock'],
    ['mdi-send', 'Pre Order'],
    // ['mdi-delete', 'Trash'],
    // ['mdi-alert-octagon', 'Spam'],
  ]

  onMounted(async () => {
    try {
      const response = await fetch('http://localhost:3001/jajan');
      jajanan.value = await response.json();
      // console.log(jajanan)
    } catch (error) {
      console.error(error);
    }
  })

  const jajanan_ready = computed(()=> {
    if(jajanan.value.length > 0) {
      let data = jajanan.value.filter((data) => data.qty !== 0);
      return data;
    }
  })
  
</script>

<!-- <script>
  export default {
    data: () => ({ drawer: null }),
  }
</script> -->
