<template>
  <div class="min-h-screen">
    <NavBar :nav-links="navLinks" />
    <!-- Banner -->
    <section class="relative w-full h-[320px] flex items-center justify-center overflow-hidden bg-cover bg-center"
      :style="{ backgroundImage: `url(${bannerImage})` }">
      <div class="absolute inset-0 bg-gradient-to-b from-campus-neutral-900/50 to-campus-neutral-900/70"></div>
      <div class="relative z-10 max-w-3xl px-8 text-center">
        <p class="campus-label text-campus-primary-200 mb-3">News & Events</p>
        <h1 class="campus-display-lg text-white mb-4">新闻动态</h1>
        <p class="text-base text-white/80 leading-relaxed max-w-xl mx-auto">了解牛犇大学最新资讯，掌握校园发展脉搏</p>
      </div>
    </section>

    <!-- News Content -->
    <section class="bg-campus-background py-20 px-8">
      <div class="max-w-7xl mx-auto">
        <div class="flex items-center gap-3 mb-10 flex-wrap">
          <button
            v-for="cat in newsCategories"
            :key="cat"
            @click="activeCategory = cat"
            :class="[
              'px-5 py-2 rounded-full text-sm font-medium transition-all duration-200',
              activeCategory === cat
                ? 'bg-campus-primary text-white'
                : 'bg-campus-surface text-campus-text-secondary hover:bg-campus-primary-100 hover:text-campus-primary'
            ]"
          >{{ cat }}</button>
        </div>

        <!-- Featured News -->
        <div v-if="activeCategory === '全部' && featuredNews" class="mb-10">
          <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 bg-campus-surface-raised border border-campus-border rounded-2xl overflow-hidden">
            <div class="h-72 lg:h-auto overflow-hidden">
              <img :src="featuredNews.image" :alt="featuredNews.title" class="w-full h-full object-cover hover:scale-105 transition-transform duration-500" />
            </div>
            <div class="p-8 flex flex-col justify-center">
              <div class="flex items-center gap-2 mb-3">
                <span class="px-2.5 py-0.5 bg-red-50 text-red-600 text-xs font-semibold rounded-full">置顶</span>
                <span class="px-2.5 py-0.5 bg-campus-primary-50 text-campus-primary text-xs font-semibold rounded-full">{{ featuredNews.category }}</span>
              </div>
              <h2 class="campus-h1 mb-3">{{ featuredNews.title }}</h2>
              <p class="text-sm text-campus-text-secondary leading-relaxed mb-4">{{ featuredNews.summary }}</p>
              <div class="flex items-center justify-between">
                <span class="text-xs text-campus-text-tertiary">{{ featuredNews.publishDate }}</span>
                <router-link :to="`/news/${featuredNews.id}`" class="text-sm font-medium text-campus-primary no-underline hover:underline flex items-center gap-1">
                  阅读全文 <ChevronRight class="w-4 h-4" />
                </router-link>
              </div>
            </div>
          </div>
        </div>

        <!-- News Grid -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <article
            v-for="item in filteredNews"
            :key="item.id"
            class="group bg-campus-surface-raised border border-campus-border rounded-xl overflow-hidden transition-all duration-300 hover:shadow-lg hover:-translate-y-1"
          >
            <div class="h-48 overflow-hidden">
              <img :src="item.image" :alt="item.title" class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110" />
            </div>
            <div class="p-5">
              <div class="flex items-center gap-2 mb-2">
                <span class="px-2.5 py-0.5 text-xs font-semibold rounded-full"
                  :class="getCategoryClass(item.category)">{{ item.category }}</span>
                <span class="text-xs text-campus-text-tertiary">{{ item.publishDate }}</span>
              </div>
              <h3 class="campus-h3 mb-2 line-clamp-2">{{ item.title }}</h3>
              <p class="text-sm text-campus-text-secondary leading-relaxed line-clamp-2 mb-3">{{ item.summary }}</p>
              <router-link :to="`/news/${item.id}`" class="text-sm font-medium text-campus-primary no-underline hover:underline flex items-center gap-1">
                阅读全文 <ChevronRight class="w-4 h-4" />
              </router-link>
            </div>
          </article>
        </div>

        <!-- Pagination -->
        <div class="flex items-center justify-center gap-2 mt-12">
          <button
            v-for="page in totalPages"
            :key="page"
            @click="currentPage = page"
            :class="[
              'w-10 h-10 rounded-lg text-sm font-medium transition-all duration-200',
              currentPage === page
                ? 'bg-campus-primary text-white'
                : 'bg-campus-surface text-campus-text-secondary hover:bg-campus-primary-100'
            ]"
          >{{ page }}</button>
          <button @click="currentPage = Math.min(currentPage + 1, totalPages)"
            :class="[
              'w-10 h-10 rounded-lg text-sm font-medium transition-all duration-200',
              'bg-campus-surface text-campus-text-secondary hover:bg-campus-primary-100'
            ]">
            <ChevronRight class="w-4 h-4 mx-auto" />
          </button>
        </div>
      </div>
    </section>

    <!-- Upcoming Events -->
    <section class="bg-campus-primary-50 py-20 px-8">
      <div class="max-w-7xl mx-auto">
        <div class="text-center mb-14">
          <p class="campus-label text-campus-primary mb-3">Upcoming Events</p>
          <h2 class="campus-display-sm mb-4">近期活动</h2>
        </div>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <div v-for="event in upcomingEvents" :key="event.id"
            class="bg-campus-surface-raised border border-campus-border rounded-xl p-6 flex gap-5 transition-all duration-300 hover:shadow-lg">
            <div class="flex-shrink-0 w-16 text-center">
              <div class="text-2xl font-bold text-campus-primary">{{ event.day }}</div>
              <div class="text-xs text-campus-text-tertiary">{{ event.month }}</div>
            </div>
            <div>
              <h3 class="campus-h3 mb-1.5">{{ event.title }}</h3>
              <p class="text-sm text-campus-text-secondary leading-relaxed mb-2">{{ event.desc }}</p>
              <div class="flex items-center gap-2 text-xs text-campus-text-tertiary">
                <MapPin class="w-3.5 h-3.5" />
                <span>{{ event.location }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Newsletter -->
    <section class="bg-campus-primary py-16 px-8">
      <div class="max-w-3xl mx-auto text-center">
        <h2 class="campus-display-sm text-white mb-4">订阅校园资讯</h2>
        <p class="text-base text-white/80 leading-relaxed mb-8">第一时间获取牛犇大学最新动态和精彩活动信息</p>
        <div class="flex items-center gap-3 max-w-md mx-auto">
          <input type="email" placeholder="请输入您的邮箱地址"
            class="flex-1 h-12 px-5 rounded-full bg-white/15 border border-white/25 text-white placeholder-white/50 text-sm focus:outline-none focus:border-white/50" />
          <button class="h-12 px-7 bg-white text-campus-primary text-sm font-semibold rounded-full transition-all duration-150 hover:scale-105 whitespace-nowrap">
            订阅
          </button>
        </div>
      </div>
    </section>

    <FooterSection :footer-links="footerLinks" :school-info="schoolInfo" />
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { ChevronRight, MapPin } from 'lucide-vue-next'
import NavBar from '../components/NavBar.vue'
import FooterSection from '../components/FooterSection.vue'
import { getNavLinks, getFooterLinks, getSchoolInfo, getNews } from '../api/campus'
import { images } from '../assets/images'

const navLinks = ref([])
const footerLinks = ref({})
const schoolInfo = ref(null)
const activeCategory = ref('全部')
const currentPage = ref(1)
const totalPages = ref(3)

const bannerImage = ref(images.newsBanner)

const newsCategories = ['全部', '学术', '校园', '通知', '荣誉']

const categoryLabelMap = {
  'NOTICE': '通知',
  'ADMIN': '校园',
  'ACADEMIC': '学术',
  'HONOR': '荣誉'
}

const formatDateStr = (date) => {
  if (!date) return ''
  const d = new Date(date)
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`
}

const featuredNews = ref({
  id: 0, title: '我校计算机科学学科进入 ESI 全球前 1%',
  summary: '根据科睿唯安最新发布的 ESI 数据，我校计算机科学学科首次进入全球前 1%，标志着该学科的国际影响力迈上新台阶。近年来，学校大力加强学科建设，引进了一批高层次人才，科研实力持续提升。',
  category: '学术', publishDate: '2026-07-15',
  image: images.newsFeatured
})

const allNews = ref([
  { id: 1, title: '我校科研团队获国家重点研发计划立项', summary: '计算机科学与生命科学交叉研究团队成功获批国家重点研发计划项目，将在人工智能辅助药物发现领域展开深入探索。', category: '学术', publishDate: '2026-07-10', image: images.newsResearch },
  { id: 2, title: '第十二届校园文化艺术节圆满落幕', summary: '历时两周的校园文化艺术节吸引了近万名师生参与，涵盖音乐、戏剧、书法、摄影等多个板块。', category: '校园', publishDate: '2026-07-05', image: images.newsFestival },
  { id: 3, title: '2026年秋季学期开学安排公告', summary: '2026年秋季学期将于9月1日正式开学，新生报到时间为8月28日至30日，请各位同学做好相关准备。', category: '通知', publishDate: '2026-06-28', image: images.newsAutumnCampus },
  { id: 4, title: '我校学生在全国大学生数学建模竞赛中获佳绩', summary: '6 支队伍获得全国一等奖，12 支队伍获得全国二等奖，参赛规模和获奖数量均创历史新高。', category: '荣誉', publishDate: '2026-06-20', image: images.newsCompetition },
  { id: 5, title: '牛犇大学-华为联合实验室揭牌成立', summary: '双方将在 5G/6G 通信、边缘计算和智能终端等领域展开深度合作，联合培养高层次技术人才。', category: '学术', publishDate: '2026-06-15', image: images.newsLabOpening },
  { id: 6, title: '校园美食节精彩来袭', summary: '来自全国各地 50 多种特色美食齐聚校园，还有厨艺大赛和美食品鉴等互动环节等你来。', category: '校园', publishDate: '2026-06-10', image: images.newsFoodFest },
  { id: 7, title: '关于暑期校园施工安全的通知', summary: '暑期期间部分教学楼将进行维修改造，请注意施工区域的安全提示，合理安排学习和出行。', category: '通知', publishDate: '2026-06-05', image: images.newsConstruction },
  { id: 8, title: '校友企业家返校分享创业经验', summary: '20 余位成功创业校友重返母校，与在校学子分享创业历程和行业洞察。', category: '校园', publishDate: '2026-06-01', image: images.newsAlumni },
  { id: 9, title: '我校教授入选国家"万人计划"', summary: '计算机学院张明远教授、材料学院王建国教授入选国家高层次人才特殊支持计划。', category: '荣誉', publishDate: '2026-05-25', image: images.newsAward }
])

const filteredNews = computed(() => {
  const list = activeCategory.value === '全部'
    ? allNews.value
    : allNews.value.filter(n => n.category === activeCategory.value)
  return list
})

const getCategoryClass = (cat) => {
  const map = {
    '学术': 'bg-blue-50 text-blue-600',
    '校园': 'bg-green-50 text-green-600',
    '通知': 'bg-amber-50 text-amber-600',
    '荣誉': 'bg-purple-50 text-purple-600'
  }
  return map[cat] || 'bg-campus-primary-50 text-campus-primary'
}

const upcomingEvents = ref([
  { id: 1, day: '25', month: '7月', title: '2026 暑期学术夏令营', desc: '面向全国高中生，为期 5 天的沉浸式学术体验，涵盖实验室参观和 mini 课程', location: '综合教学楼 A 区' },
  { id: 2, day: '01', month: '8月', title: '新生入学指导日', desc: '本科新生校园参观、选课指导、社团招新等系列活动', location: '学生活动中心' },
  { id: 3, day: '15', month: '8月', title: '国际学术研讨会', desc: '人工智能与可持续发展主题国际会议，邀请 10 余位国际知名学者做报告', location: '学术报告厅' },
  { id: 4, day: '28', month: '8月', title: '2026 级新生报到', desc: '新生报到注册、入住宿舍、校园导航，开启大学生活新篇章', location: '各学院报到处' },
  { id: 5, day: '01', month: '9月', title: '秋季学期开学典礼', desc: '2026-2027 学年第一学期正式开学，校长致辞、新生代表发言', location: '大礼堂' },
  { id: 6, day: '10', month: '9月', title: '教师节表彰大会', desc: '表彰在教学、科研、管理等方面做出突出贡献的教职员工', location: '学术报告厅' }
])

onMounted(async () => {
  try {
    const [navRes, footerRes, schoolRes, newsRes] = await Promise.all([
      getNavLinks(), getFooterLinks(), getSchoolInfo(), getNews()
    ])
    if (navRes.data.data) navLinks.value = navRes.data.data
    if (footerRes.data.data) footerLinks.value = footerRes.data.data
    if (schoolRes.data.data) schoolInfo.value = schoolRes.data.data
    if (newsRes.data.success && newsRes.data.data) {
      allNews.value = newsRes.data.data.map(item => ({
        ...item,
        category: categoryLabelMap[item.category] || item.category,
        publishDate: formatDateStr(item.publishDate)
      }))
    }
  } catch (e) {
    navLinks.value = [
      { id: 1, label: '首页', path: '/', isActive: false, sortOrder: 1 },
      { id: 2, label: '院系设置', path: '/departments', isActive: false, sortOrder: 2 },
      { id: 3, label: '招生就业', path: '/admissions', isActive: false, sortOrder: 3 },
      { id: 4, label: '科学研究', path: '/research', isActive: false, sortOrder: 4 },
      { id: 5, label: '校园生活', path: '/campus-life', isActive: false, sortOrder: 5 },
      { id: 6, label: '新闻动态', path: '/news', isActive: true, sortOrder: 6 }
    ]
    schoolInfo.value = { name: '牛犇大学', address: '北京市海淀区学院路100号', phone: '010-62888888' }
  }
})
</script>
