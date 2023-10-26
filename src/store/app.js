// Utilities
import { defineStore } from 'pinia'

export const useApiconfigStore = defineStore('apiconfig', {
  state: () => ({
    baseAPI : "http://172.9.1.157:3001/"
  }),
})
