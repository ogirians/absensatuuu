<template>
    <v-app id="inspire">
      <v-navigation-drawer v-model="drawer">
        <v-list>
          <v-list-item
            v-for="[icon, text,to] in links"
            :key="icon"
            :prepend-icon="icon"
            :title="text"
            link
            :to="to"
          ></v-list-item>
        </v-list>
        <template v-slot:append>
         <v-divider></v-divider>
          <v-list-item  prepend-icon="mdi-circle" title="keluar" to="/">
         </v-list-item>
        </template>
      </v-navigation-drawer>
  
      <v-app-bar>
        <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
  
        <v-app-bar-title>Absensatuu</v-app-bar-title>
      </v-app-bar>
      <v-main>
        <transition name="scroll-x-transition" class="mt-3 mr-3" style="position: absolute; right: 0; bottom: 10; z-index: 1;">
          <v-alert v-model="showAlertSuccess" transition="fade-transition" text="berhasil" density="compact" type="success" class="mb-5" closable  border="top">
          </v-alert>
        </transition>
        <transition name="scroll-x-transition" class="mt-3 mr-3" style="position: absolute; right: 0; bottom: 10; z-index: 1;">
          <v-alert v-model="showAlertError" transition="fade-transition" text="gagal" density="compact" type="error" class="mb-5" closable  border="top">
          </v-alert>
        </transition>
        <v-container class="mt-5">
          <v-text-field v-model="filter" type="text" density="compact" variant="outlined" placeholder="makaroni" label="search" clearable></v-text-field>
          <v-row>
            <v-menu 
                v-for="jajan in filterJajan"
                :key="jajan._id"
                location="center"
                transition="scale-transition"
            >
              <template v-slot:activator="{ props }">
                <v-col
                cols="6"
                md="3"
                v-bind="props"
                >
                  <v-card>
                    <v-card-title class="bg-primary text-caption text-md-h7">{{jajan.nama}}</v-card-title>
                    <v-divider></v-divider>
                    <v-card-item>
                      <v-img
                        height="150" src="@/assets/jajan_default.png" 
                      /> 
                      <v-card-text class="d-flex justify-center py-0">{{  Intl.NumberFormat('id', { style: 'currency', currency: 'IDR' }).format(jajan.harga) }}</v-card-text>
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
                  <v-list-item-title @click="showOverlay('jual',jajan._id)">JUAL</v-list-item-title>
                </v-list-item>
                <v-divider></v-divider>
                <v-list-item :value="1">
                  <v-list-item-title @click="showOverlay('tambah',jajan._id)">TAMBAH</v-list-item-title>
                </v-list-item>
                <v-divider></v-divider>
                <v-list-item :value="2">
                  <v-list-item-title @click="showOverlay('delete',jajan._id)">HAPUS</v-list-item-title>
                </v-list-item>
                <v-divider></v-divider>
              </v-list>
            </v-menu>
          </v-row>
          <v-btn @click="getData()" class="my-10">refresh</v-btn>
        </v-container>
      </v-main>
      <v-overlay v-model="overlayJual" contained class="align-center justify-center">
        <v-responsive class="mx-auto align-center justify-center" width="300">
          <v-card>
            <v-card-title>Jual</v-card-title>
            <v-divider></v-divider>
            <v-text-field density="compact" variant="outlined" class="mx-5 my-4" v-model="form_jual.nama" label="nama" hide-details="auto" type="text"></v-text-field>
            <v-text-field density="compact" variant="outlined" class="mx-5 my-4" v-model="form_jual.jumlah" label="jumlah" hide-details="auto" type="number"></v-text-field>
            
            <!-- Use d-flex and justify-end to move the button to the right -->
            <div class="d-flex justify-end ma-4">
              <v-btn color="success" @click="jualJajan()">gass</v-btn>
            </div>
          </v-card>
        </v-responsive>
      </v-overlay>
      <v-overlay v-model="overlayTambah" contained class="align-center justify-center">
        <v-responsive class="mx-auto align-center justify-center" width="300">
          <v-card>
            <v-card-title>Tambah</v-card-title>
            <v-divider></v-divider>
            <v-text-field density="compact" variant="outlined" class="mx-5 my-4" v-model="form_jual.jumlah" label="jumlah" hide-details="auto" type="number"></v-text-field>
            <!-- Use d-flex and justify-end to move the button to the right -->
            <div class="d-flex justify-end ma-4">
              <v-btn color="success" @click="tambahJajan()">gass</v-btn>
            </div>
          </v-card>
        </v-responsive>
      </v-overlay>
      <v-overlay v-model="overlayDelete" contained class="align-center justify-center">
        <v-responsive class="mx-auto align-center justify-center" width="300">
          <v-card>
            <v-card-title>Delete</v-card-title>
            <v-divider></v-divider>
            <v-card-text>
              yakin ingin menghapus ?             
            </v-card-text>
            <v-divider></v-divider>
            <!-- Use d-flex and justify-end to move the button to the right -->
            <div class="d-flex justify-end ma-4">
              <v-btn color="success" @click="hapusJajan()">gass</v-btn>
            </div>
          </v-card>
        </v-responsive>
      </v-overlay>
    </v-app>
  </template>
  
  <script setup>
  import { computed } from 'vue';
  import { ref, onMounted } from 'vue'
  import { useApiconfigStore } from '../store/app'
  import moment from 'moment';

  const storeApiconfig = useApiconfigStore();
  
    const drawer = ref(null);
    const jajanan = ref('');
    const showAlertSuccess = ref(false)
    const showAlertError = ref(false)
    const links = [
      ['mdi-inbox-arrow-down', 'Stock', '/home_admin_'],
      ['mdi-send', 'Pre Order',''],
      ['mdi-download', 'Update Stok',''],
      // ['mdi-alert-octagon', ''],
    ]

    const overlayJual = ref(false)
    const overlayTambah = ref(false)
    const overlayDelete = ref(false)
    const selectedJajan = ref('');
    const filter = ref('');
    const form_jual = ref({nama: '', jumlah: 0})
  
    onMounted(async () => {
      getData();
    })


    const getData = async () => {
      try {
        const response = await fetch(storeApiconfig.baseAPI+'jajan');
        jajanan.value = await response.json();
        // console.log(jajanan)
      } catch (error) {
        console.error(error);
      }
    }

    const filterJajan = computed(() => {
      if(jajanan.value.length > 0){
        let data = jajanan.value.filter((data) => {
            return data.nama.toLowerCase().includes(filter.value ? filter.value.toLowerCase() : '' )
          })
        return data
      }
    })

    const showOverlay = (menu,id) => {
      
      if(menu == 'jual'){
        overlayJual.value = true;
      }
      if(menu == 'tambah'){
        overlayTambah.value = true;
      }
      if(menu == 'delete'){
        overlayDelete.value = true;
      }

      selectedJajan.value = id
    }

    const jualJajan = async () => {
        let currentDate = moment().format('YYYY-MM-DD HH:mm:ss');
        console.log(currentDate)
        await fetch(storeApiconfig.baseAPI+'jajan/terjual/'+selectedJajan.value, {
          method: "PUT",
          headers: {
            "Content-Type": "application/json", // Set the content type to JSON
          },
          body: JSON.stringify({jumlah: form_jual.value.jumlah}),
        })  
        .then((response) => {
          response.json().then((data) => {
            // this.fact = data[0].fact;
            // console.log(data);
            // jajanan.value = data
            getData();
          });
        })
        .catch((err) => {
          console.error(err);
          showAlertError.value = true
        });

        await fetch(storeApiconfig.baseAPI+'transaksi', {
          method: "POST",
          headers: {
            "Content-Type": "application/json", // Set the content type to JSON
          },
          body: JSON.stringify({
            tanggal     : currentDate,
            nama_pembeli: form_jual.value.nama,
            jajan       : selectedJajan.value,
            jumlah      : form_jual.value.jumlah,
          }),
        })  
        .then((response) => {
          response.json().then((data) => {
            // this.fact = data[0].fact;
            console.log(data);
            // jajanan.value(data)
            showAlertSuccess.value = true
            overlayJual.value = false
          });
        })
        .catch((err) => {
          console.error(err);
            showAlertError.value = true
        });
    }

    const tambahJajan = async () => {
      await fetch(storeApiconfig.baseAPI+'jajan/'+selectedJajan.value, {
          method: "PUT",
          headers: {
            "Content-Type": "application/json", // Set the content type to JSON
          },
          body: JSON.stringify({jumlah : form_jual.value.jumlah}),
        })  
        .then((response) => {
          response.json().then((data) => {
            getData();
            overlayTambah.value = false
            showAlertSuccess.value = true
          });
        })
        .catch((err) => {
          console.error(err);
          showAlertError.value = true
        });

    }
    const hapusJajan = async () => {
      await fetch(storeApiconfig.baseAPI+'jajan/'+selectedJajan.value, {
          method: "DELETE",
          headers: {
            "Content-Type": "application/json", // Set the content type to JSON
          },
        })  
        .then((response) => {
          response.json().then((data) => {
            getData();
            overlayDelete.value = false
            showAlertSuccess.value = true
          });
        })
        .catch((err) => {
          console.error(err);
          showAlertError.value = true
        });

    }
  
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

  
  