<template>
  <section class="bg-campus-primary-50 py-12 px-8">
    <div class="max-w-7xl mx-auto grid grid-cols-2 md:grid-cols-4 gap-6 text-center">
      <div v-for="stat in stats" :key="stat.id" class="animate-fade-in">
        <div class="campus-display-md text-campus-primary mb-1 font-variant-numeric" :style="{ fontSize: 'clamp(1.5rem, 3vw, 2.5rem)' }">
          {{ stat.statValue }}<span class="text-sm">+</span>
        </div>
        <p class="text-sm text-campus-text-secondary m-0 whitespace-nowrap">{{ stat.statLabel }}</p>
      </div>
    </div>
  </section>
</template>

<script setup>
defineProps({
  stats: {
    type: Array,
    default: () => []
  }
})
</script>

<style scoped>
@keyframes fade-in {
  from { opacity: 0; transform: translateY(20px); }
  to { opacity: 1; transform: translateY(0); }
}

.animate-fade-in {
  animation: fade-in 0.6s ease-out forwards;
}

.animate-fade-in:nth-child(1) { animation-delay: 0.1s; }
.animate-fade-in:nth-child(2) { animation-delay: 0.2s; }
.animate-fade-in:nth-child(3) { animation-delay: 0.3s; }
.animate-fade-in:nth-child(4) { animation-delay: 0.4s; }
</style>