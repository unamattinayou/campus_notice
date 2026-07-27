<template>
  <footer class="bg-campus-neutral-900 py-16 px-8">
    <div class="max-w-7xl mx-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-12 mb-12">
      <div>
        <div class="font-campus-display text-xl font-bold text-white mb-4">{{ schoolInfo?.name || '牛犇大学' }}</div>
        <p class="text-sm text-campus-neutral-400 leading-relaxed">
          {{ schoolInfo?.address || '北京市海淀区学院路100号' }}<br>
          {{ schoolInfo?.postalCode || '邮编：100081' }}<br>
          {{ schoolInfo?.phone || '电话：010-62888888' }}
        </p>
      </div>
      <div v-for="(links, section) in footerLinks" :key="section">
        <h4 class="text-sm font-semibold text-white mb-4">{{ section }}</h4>
        <nav class="flex flex-col gap-2.5">
          <router-link
            v-for="link in links"
            :key="link.id"
            :to="link.path"
            class="text-sm text-campus-neutral-400 no-underline transition-colors duration-150 hover:text-white"
          >{{ link.label }}</router-link>
        </nav>
      </div>
    </div>
    <div class="max-w-7xl mx-auto pt-6 border-t border-campus-neutral-700">
      <p class="text-xs text-campus-neutral-500 text-center">&copy; {{ currentYear }} 牛犇大学 版权所有</p>
    </div>
  </footer>
</template>

<script setup>
import { computed } from 'vue'

defineProps({
  footerLinks: {
    type: Object,
    default: () => ({})
  },
  schoolInfo: {
    type: Object,
    default: null
  }
})

const currentYear = computed(() => new Date().getFullYear())
</script>
