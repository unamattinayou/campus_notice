<template>
  <section class="relative w-full min-h-[600px] flex items-center justify-center overflow-hidden bg-cover bg-center" :style="{ backgroundImage: `url(${heroImage})` }">
    <div class="absolute inset-0 bg-gradient-to-b from-campus-neutral-900/45 to-campus-neutral-900/65"></div>
    <div class="relative z-10 max-w-3xl px-8 pt-32 pb-20 text-center">
      <h1 class="campus-display-lg text-white text-center mb-4 leading-[1.08]">{{ heroTitle }}</h1>
      <p class="text-base md:text-lg text-white/85 leading-relaxed mb-10 max-w-xl mx-auto">{{ heroSubtitle }}</p>
      <div class="flex items-center justify-center gap-4 flex-wrap">
        <a 
          href="#" 
          class="inline-flex items-center justify-center h-12 px-8 bg-campus-primary text-white text-base font-semibold rounded-full no-underline whitespace-nowrap transition-all duration-150 hover:bg-campus-primary-dark hover:scale-105"
        >了解详情</a>
        <a 
          href="#" 
          class="inline-flex items-center justify-center h-12 px-8 bg-transparent text-white text-base font-semibold border-2 border-white/60 rounded-full no-underline whitespace-nowrap transition-all duration-150 hover:border-white hover:bg-white/10 hover:scale-105"
        >虚拟校园</a>
      </div>
    </div>
  </section>
</template>

<script setup>
defineProps({
  heroTitle: {
    type: String,
    default: '在这里，遇见未来'
  },
  heroSubtitle: {
    type: String,
    default: '探索知识的边界，成就卓越的人生'
  },
  heroImage: {
    type: String,
    default: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=beautiful%20university%20campus%20landscape%20with%20modern%20buildings%20and%20green%20trees%20at%20sunset%20warm%20lighting&image_size=landscape_16_9'
  }
})
</script>