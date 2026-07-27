<template>
  <div class="min-h-screen">
    <NavBar :nav-links="navLinks" />
    <!-- Page Banner -->
    <section class="relative w-full h-[320px] flex items-center justify-center overflow-hidden bg-cover bg-center"
      :style="{ backgroundImage: `url(${bannerImage})` }">
      <div class="absolute inset-0 bg-gradient-to-b from-campus-neutral-900/50 to-campus-neutral-900/70"></div>
      <div class="relative z-10 max-w-3xl px-8 text-center">
        <p class="campus-label text-campus-primary-200 mb-3">Departments & Schools</p>
        <h1 class="campus-display-lg text-white mb-4">院系设置</h1>
        <p class="text-base text-white/80 leading-relaxed max-w-xl mx-auto">涵盖文理工商艺等多个学科门类，构建跨学科融合的创新人才培养体系</p>
      </div>
    </section>

    <!-- Department Stats -->
    <section class="bg-campus-surface py-10 px-8">
      <div class="max-w-7xl mx-auto grid grid-cols-2 md:grid-cols-4 gap-6">
        <div v-for="stat in departmentStats" :key="stat.id" class="text-center">
          <div class="campus-display-sm text-campus-primary mb-1">{{ stat.value }}</div>
          <div class="text-sm text-campus-text-secondary">{{ stat.label }}</div>
        </div>
      </div>
    </section>

    <!-- Department List -->
    <section class="bg-campus-background py-20 px-8">
      <div class="max-w-7xl mx-auto">
        <!-- Category Filter -->
        <div class="flex items-center gap-3 mb-10 flex-wrap">
          <button
            v-for="cat in categories"
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

        <!-- Department Cards -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <div
            v-for="dept in filteredDepartments"
            :key="dept.id"
            class="group bg-campus-surface-raised border border-campus-border rounded-xl overflow-hidden transition-all duration-300 hover:shadow-lg hover:-translate-y-1"
          >
            <div class="h-48 bg-gradient-to-br from-campus-primary-100 to-campus-primary-200 flex items-center justify-center">
              <span class="text-5xl font-bold text-campus-primary/20 font-campus-display">{{ dept.code }}</span>
            </div>
            <div class="p-6">
              <div class="flex items-center gap-2 mb-2">
                <span class="px-2.5 py-0.5 bg-campus-primary-50 text-campus-primary text-xs font-semibold rounded-full">{{ dept.category }}</span>
              </div>
              <h3 class="campus-h3 mb-2">{{ dept.name }}</h3>
              <p class="text-sm text-campus-text-secondary leading-relaxed mb-4 line-clamp-3">{{ dept.description }}</p>
              <div class="flex items-center justify-between">
                <div class="flex gap-4">
                  <span class="text-xs text-campus-text-tertiary">{{ dept.facultyCount }} 名教师</span>
                  <span class="text-xs text-campus-text-tertiary">{{ dept.programCount }} 个专业</span>
                </div>
                <a href="#" class="text-sm font-medium text-campus-primary no-underline hover:underline flex items-center gap-1">
                  了解更多 <ChevronRight class="w-4 h-4" />
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Featured Department -->
    <section class="bg-campus-primary-50 py-20 px-8">
      <div class="max-w-7xl mx-auto grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
        <div>
          <p class="campus-label text-campus-primary mb-3">Featured</p>
          <h2 class="campus-display-sm text-campus-neutral-900 mb-4">重点学科：计算机科学与技术</h2>
          <p class="text-base text-campus-text-secondary leading-relaxed mb-6">
            我校计算机科学学科进入 ESI 全球前 1%，拥有国家重点实验室和省部级科研平台 5 个。
            近年来在人工智能、自然语言处理、计算机视觉等领域取得了一系列突破性成果，
            多篇论文发表于 Nature、Science 等顶级期刊。
          </p>
          <ul class="space-y-3 mb-8">
            <li v-for="item in highlights" :key="item" class="flex items-start gap-3">
              <CheckCircle class="w-5 h-5 text-campus-primary mt-0.5 flex-shrink-0" />
              <span class="text-sm text-campus-text-secondary">{{ item }}</span>
            </li>
          </ul>
          <a href="#" class="inline-flex items-center justify-center h-11 px-7 bg-campus-primary text-white text-sm font-semibold rounded-full no-underline transition-all duration-150 hover:bg-campus-primary-dark hover:scale-105">
            查看学科详情
          </a>
        </div>
        <div class="rounded-2xl overflow-hidden shadow-xl">
          <img :src="featuredImage" alt="重点学科" class="w-full h-[360px] object-cover" />
        </div>
      </div>
    </section>

    <FooterSection :footer-links="footerLinks" :school-info="schoolInfo" />
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { ChevronRight, CheckCircle } from 'lucide-vue-next'
import NavBar from '../components/NavBar.vue'
import FooterSection from '../components/FooterSection.vue'
import { getNavLinks, getFooterLinks, getSchoolInfo } from '../api/campus'
import { images } from '../assets/images'

const navLinks = ref([])
const footerLinks = ref({})
const schoolInfo = ref(null)
const activeCategory = ref('全部')

const bannerImage = ref(images.departmentsBanner)
const featuredImage = ref(images.departmentsFeatured)

const departmentStats = ref([
  { id: 1, value: '12', label: '学院' },
  { id: 2, value: '68', label: '系/研究所' },
  { id: 3, value: '156', label: '本硕博专业' },
  { id: 4, value: '2,800', label: '教职员工' }
])

const categories = ['全部', '理学', '工学', '文学', '管理学', '艺术学']

const departments = ref([
  { id: 1, code: 'CS', name: '计算机科学与技术学院', category: '工学', description: '聚焦人工智能、大数据与软件工程，培养面向未来的技术创新人才', facultyCount: 180, programCount: 8 },
  { id: 2, code: 'EE', name: '电子工程学院', category: '工学', description: '涵盖微电子、通信工程、集成电路设计等前沿方向，产学研深度融合', facultyCount: 150, programCount: 7 },
  { id: 3, code: 'CE', name: '土木工程学院', category: '工学', description: '在智能建造、绿色建筑等领域享有盛誉，拥有国家级实验教学示范中心', facultyCount: 120, programCount: 5 },
  { id: 4, code: 'ME', name: '机械工程学院', category: '工学', description: '融合智能制造与机器人技术，建设先进制造实验室与产业合作基地', facultyCount: 110, programCount: 5 },
  { id: 5, code: 'EC', name: '经济管理学院', category: '管理学', description: '融合经济学与管理学前沿理论，注重实践与国际化视野', facultyCount: 160, programCount: 9 },
  { id: 6, code: 'SC', name: '数学与统计学院', category: '理学', description: '基础数学与应用数学并重，数据科学与人工智能交叉研究特色鲜明', facultyCount: 90, programCount: 4 },
  { id: 7, code: 'LS', name: '生命科学学院', category: '理学', description: '从基因到生态，探索生命奥秘，推动生物医药前沿突破', facultyCount: 130, programCount: 6 },
  { id: 8, code: 'CH', name: '化学与材料学院', category: '理学', description: '在新型功能材料、绿色化学等领域拥有国际领先的研究成果', facultyCount: 100, programCount: 5 },
  { id: 9, code: 'LC', name: '文学与传播学院', category: '文学', description: '传承人文精神，在数字时代探索文学创作与传媒创新', facultyCount: 85, programCount: 6 },
  { id: 10, code: 'LW', name: '法学院', category: '文学', description: '培养德法兼修的高素质法律人才，聚焦数字法治与知识产权', facultyCount: 70, programCount: 4 },
  { id: 11, code: 'AD', name: '艺术设计学院', category: '艺术学', description: '融合传统美学与现代设计理念，激发创造力与审美表达', facultyCount: 65, programCount: 5 },
  { id: 12, code: 'MU', name: '音乐与舞蹈学院', category: '艺术学', description: '传承经典艺术教育，创新音乐表演与舞蹈编创教学模式', facultyCount: 55, programCount: 4 }
])

const highlights = ref([
  'ESI 全球前 1% 学科，国家"双一流"建设学科',
  '国家重点实验室 1 个，省部级科研平台 5 个',
  '年均科研经费超过 2 亿元，SCI 论文 500+ 篇/年',
  '与华为、腾讯、百度等头部企业建立联合实验室'
])

const filteredDepartments = computed(() => {
  if (activeCategory.value === '全部') return departments.value
  return departments.value.filter(d => d.category === activeCategory.value)
})

onMounted(async () => {
  try {
    const [navRes, footerRes, schoolRes] = await Promise.all([
      getNavLinks(), getFooterLinks(), getSchoolInfo()
    ])
    if (navRes.data.data) navLinks.value = navRes.data.data
    if (footerRes.data.data) footerLinks.value = footerRes.data.data
    if (schoolRes.data.data) schoolInfo.value = schoolRes.data.data
  } catch (e) {
    navLinks.value = [
      { id: 1, label: '首页', path: '/', isActive: false, sortOrder: 1 },
      { id: 2, label: '院系设置', path: '/departments', isActive: true, sortOrder: 2 },
      { id: 3, label: '招生就业', path: '/admissions', isActive: false, sortOrder: 3 },
      { id: 4, label: '科学研究', path: '/research', isActive: false, sortOrder: 4 },
      { id: 5, label: '校园生活', path: '/campus-life', isActive: false, sortOrder: 5 },
      { id: 6, label: '新闻动态', path: '/news', isActive: false, sortOrder: 6 }
    ]
    schoolInfo.value = { name: '牛犇大学', address: '北京市海淀区学院路100号', phone: '010-62888888' }
  }
})
</script>
