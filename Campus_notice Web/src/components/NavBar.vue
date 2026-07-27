<template>
  <nav class="sticky top-0 z-50 bg-campus-background border-b border-campus-border">
    <div class="max-w-7xl mx-auto px-8 h-18 flex items-center justify-between">
      <router-link to="/" class="font-campus-display text-xl font-bold text-campus-primary no-underline whitespace-nowrap tracking-tight">牛犇大学</router-link>
      <div class="hidden md:flex items-center gap-8">
        <router-link
          v-for="link in navLinks"
          :key="link.id"
          :to="link.path"
          :class="[
            'text-sm font-medium no-underline whitespace-nowrap transition-colors duration-150',
            link.isActive ? 'text-campus-primary' : 'text-campus-text-secondary hover:text-campus-primary'
          ]"
        >{{ link.label }}</router-link>
      </div>
      <a
        href="#"
        class="inline-flex items-center justify-center h-10 px-5 bg-campus-primary text-white text-sm font-semibold rounded-full no-underline whitespace-nowrap transition-all duration-150 hover:bg-campus-primary-dark hover:scale-105"
      >在线申请</a>
      <button
        class="md:hidden p-2 text-campus-text-secondary hover:text-campus-primary"
        @click="toggleMenu"
      >
        <Menu v-if="!isMenuOpen" class="w-6 h-6" />
        <X v-else class="w-6 h-6" />
      </button>
    </div>
    <div
      v-if="isMenuOpen"
      class="md:hidden bg-campus-background border-b border-campus-border"
    >
      <div class="px-8 py-4 flex flex-col gap-4">
        <router-link
          v-for="link in navLinks"
          :key="link.id"
          :to="link.path"
          :class="[
            'text-base font-medium no-underline whitespace-nowrap transition-colors duration-150',
            link.isActive ? 'text-campus-primary' : 'text-campus-text-secondary hover:text-campus-primary'
          ]"
          @click="isMenuOpen = false"
        >{{ link.label }}</router-link>
      </div>
    </div>
  </nav>
</template>

<script setup>
import { ref } from 'vue'
import { Menu, X } from 'lucide-vue-next'

defineProps({
  navLinks: {
    type: Array,
    default: () => []
  }
})

const isMenuOpen = ref(false)

const toggleMenu = () => {
  isMenuOpen.value = !isMenuOpen.value
}
</script>
