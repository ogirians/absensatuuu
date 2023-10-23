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
            <v-menu 
                v-for="jajan in jajanan"
                :key="jajan.id"
                location="center"
            >
              <template v-slot:activator="{ props }">
                <v-col
                cols="6"
                md="3"
                v-bind="props"
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
              </template>
  
              <v-list>
                <v-list-item :value="0">
                  <v-list-item-title>JUAL</v-list-item-title>
                </v-list-item>
                <v-divider></v-divider>
                <v-list-item :value="1">
                  <v-list-item-title>TAMBAH</v-list-item-title>
                </v-list-item>
                <v-divider></v-divider>
                <v-list-item :value="2">
                  <v-list-item-title>HAPUS</v-list-item-title>
                </v-list-item>
                <v-divider></v-divider>
              </v-list>
            </v-menu>
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
      ['mdi-download', 'Update Stok'],
      // ['mdi-alert-octagon', ''],
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

  <script>
  export default {
    data: () => ({
      items: [
        { title: 'Click Me' },
        { title: 'Click Me' },
        { title: 'Click Me' },
        { title: 'Click Me 2' },
      ],
      locations: [
        'top',
        'bottom',
        'start',
        'end',
        'center',
      ],
      location: 'end',
    }),
  }
</script>
  