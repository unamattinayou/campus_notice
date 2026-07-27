<template>
  <section class="bg-campus-background py-20 px-8">
    <div class="max-w-7xl mx-auto">
      <div class="flex flex-col md:flex-row items-center justify-between mb-12">
        <h2 class="campus-h1 mb-4 md:mb-0">最新动态</h2>
        <a href="#" class="text-sm font-medium text-campus-primary no-underline whitespace-nowrap transition-opacity duration-150 hover:opacity-70">查看全部</a>
      </div>
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <article 
          v-for="newsItem in news" 
          :key="newsItem.id"
          class="group border border-campus-border border-l-3 border-campus-primary rounded-lg p-6 bg-campus-surface-raised transition-all duration-300 hover:-translate-y-1 cursor-pointer"
        >
          <div class="flex items-center gap-2 mb-3">
            <span class="inline-flex items-center justify-center h-5.5 px-2 bg-campus-primary-100 text-campus-primary text-xs font-semibold rounded-sm whitespace-nowrap">{{ getCategoryLabel(newsItem.category) }}</span>
            <time class="text-xs text-campus-text-tertiary whitespace-nowrap">{{ formatDate(newsItem.publishDate) }}</time>
          </div>
          <h3 class="campus-h3 mb-2 line-clamp-2">{{ newsItem.title }}</h3>
          <p class="text-sm text-campus-text-secondary leading-relaxed line-clamp-3">{{ newsItem.summary }}</p>
        </article>
      </div>
    </div>
  </section>
</template>

<script setup>
defineProps({
  news: {
    type: Array,
    default: () => []
  }
})

const formatDate = (date) => {
  if (!date) return ''
  const d = new Date(date)
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`
}

const getCategoryLabel = (cat) => {
  const map = {
    'NOTICE': '通知',
    'ADMIN': '校园',
    'ACADEMIC': '学术',
    'HONOR': '荣誉'
  }
  return map[cat] || (cat || '校园')
}
</script>