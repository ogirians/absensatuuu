<template>
  <v-app id="inspire">
    <v-navigation-drawer v-model="drawer">
      <v-list class="flex">
        <v-list-item
          v-for="[icon, text, to] in links"
          :key="icon"
          :prepend-icon="icon"
          :title="text"
          :to="to"
        ></v-list-item>
        <v-divider></v-divider>
      </v-list>
      <template v-slot:append>
         <v-divider></v-divider>
          <v-list-item  prepend-icon="mdi-circle" title="admin" @click="showOverlay()">
         </v-list-item>
      </template>
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
    <v-overlay v-model="overlay" contained class="align-center justify-center">
      <v-responsive class="mx-auto align-center justify-center" width="300">
        <v-text-field v-model="password" label="password" hide-details="auto" type="password"></v-text-field>
        
        <!-- Use d-flex and justify-end to move the button to the right -->
        <div class="d-flex justify-end mt-4">
          <v-btn color="success" @click="toAdmin()">gass</v-btn>
        </div>
      </v-responsive>
    </v-overlay>
  </v-app>
</template>

<script setup>
import router from '@/router';
import { computed } from 'vue';
import { ref, onMounted } from 'vue'

  const drawer = ref(null);
  const jajanan = ref('');
  const password = ref('');
  const overlay = ref(false);

  const links = [
    ['mdi-inbox-arrow-down', 'Stock', '/'],
    ['mdi-send', 'Pre Order',''],
    // ['mdi-delete', 'Trash'],
    // ['mdi-alert-octagon', 'Spam'],
  ]

  onMounted(async () => {
    try {
      const response = await fetch('http://172.9.1.157:3001/jajan');
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

  const showOverlay = () => {
      overlay.value = true;
  }

  const toAdmin = () => {
    if(password.value == '14045'){
      router.push({name : 'home_admin'})
    }
  }
  
</script>

<!-- <script>
  export default {
    data: () => ({ drawer: null }),
  }
</script> -->
