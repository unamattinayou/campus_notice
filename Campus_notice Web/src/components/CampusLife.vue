<template>
  <section class="bg-campus-surface py-20 px-8">
    <div class="max-w-7xl mx-auto grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">
      <div>
        <img 
          :src="campusImage" 
          alt="学生们在现代图书馆中协作学习" 
          class="w-full h-auto rounded-xl object-cover aspect-[4/3]" 
          loading="lazy"
        >
      </div>
      <div>
        <h2 class="campus-h1 mb-4">多彩校园生活</h2>
        <p class="text-base text-campus-text-secondary leading-relaxed mb-8">牛犇大学拥有丰富多彩的校园文化活动。从学术讲座到文艺演出，从体育竞技到志愿服务，每一位学子都能找到属于自己的舞台，在青春岁月中收获成长与友谊。</p>
        <div class="flex flex-col gap-5">
          <div 
            v-for="feature in campusLifeFeatures" 
            :key="feature.id"
            class="flex items-start gap-4"
          >
            <div class="w-2 h-2 rounded-full bg-campus-primary mt-3 flex-shrink-0"></div>
            <div>
              <h3 class="campus-h3 mb-1">{{ feature.title }}</h3>
              <p class="text-sm text-campus-text-secondary leading-relaxed">{{ feature.description }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
defineProps({
  campusLifeFeatures: {
    type: Array,
    default: () => []
  },
  campusImage: {
    type: String,
    default: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=modern%20university%20library%20interior%20with%20students%20studying%20together%20bright%20natural%20light&image_size=landscape_4_3'
  }
})
</script>