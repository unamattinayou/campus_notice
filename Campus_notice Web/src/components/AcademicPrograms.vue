<template>
  <section class="bg-campus-background py-20 px-8">
    <div class="max-w-7xl mx-auto">
      <div class="text-center mb-14">
        <h2 class="campus-h1 mb-3">探索学术天地</h2>
        <p class="text-base md:text-lg text-campus-text-secondary max-w-xl mx-auto leading-relaxed">多学科交叉融合，培养未来领军人才</p>
      </div>
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <div 
          v-for="program in academicPrograms" 
          :key="program.id"
          class="group bg-campus-surface-raised border border-campus-border rounded-xl p-8 transition-all duration-300 hover:shadow-lg hover:-translate-y-1 cursor-pointer"
        >
          <div class="w-12 h-12 rounded-xl bg-campus-primary-100 flex items-center justify-center mb-5">
            <span class="text-base font-bold text-campus-primary">{{ program.code }}</span>
          </div>
          <h3 class="campus-h3 mb-2">{{ program.name }}</h3>
          <p class="text-sm text-campus-text-secondary leading-relaxed line-clamp-3">{{ program.description }}</p>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
defineProps({
  academicPrograms: {
    type: Array,
    default: () => []
  }
})
</script>