<template>
  <div class="min-h-screen">
    <NavBar :nav-links="navLinks" />
    <!-- Banner -->
    <section class="relative w-full h-[320px] flex items-center justify-center overflow-hidden bg-cover bg-center"
      :style="{ backgroundImage: `url(${bannerImage})` }">
      <div class="absolute inset-0 bg-gradient-to-b from-campus-neutral-900/50 to-campus-neutral-900/70"></div>
      <div class="relative z-10 max-w-3xl px-8 text-center">
        <p class="campus-label text-campus-primary-200 mb-3">Admissions & Careers</p>
        <h1 class="campus-display-lg text-white mb-4">招生就业</h1>
        <p class="text-base text-white/80 leading-relaxed max-w-xl mx-auto">开启你的大学之旅，从这里走向卓越的未来</p>
      </div>
    </section>

    <!-- Quick Entry -->
    <section class="bg-campus-surface py-14 px-8">
      <div class="max-w-7xl mx-auto grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
        <a v-for="entry in quickEntries" :key="entry.id" href="#"
          class="group flex items-center gap-4 bg-campus-surface-raised border border-campus-border rounded-xl p-6 no-underline transition-all duration-300 hover:shadow-lg hover:-translate-y-1">
          <div class="w-12 h-12 rounded-xl flex items-center justify-center flex-shrink-0"
            :class="entry.bgClass">
            <component :is="entry.icon" class="w-6 h-6" :class="entry.iconClass" />
          </div>
          <div>
            <div class="campus-h3 mb-0.5">{{ entry.title }}</div>
            <div class="text-xs text-campus-text-tertiary">{{ entry.desc }}</div>
          </div>
        </a>
      </div>
    </section>

    <!-- Admissions Section -->
    <section class="bg-campus-background py-20 px-8">
      <div class="max-w-7xl mx-auto">
        <div class="text-center mb-14">
          <p class="campus-label text-campus-primary mb-3">Undergraduate & Graduate</p>
          <h2 class="campus-display-sm mb-4">招生计划</h2>
          <p class="text-base text-campus-text-secondary max-w-xl mx-auto leading-relaxed">面向全国招收优秀学子，提供本科、硕士、博士多层次人才培养</p>
        </div>

        <!-- Tabs -->
        <div class="flex items-center gap-1 mb-10 border-b border-campus-border">
          <button
            v-for="tab in admissionTabs"
            :key="tab.key"
            @click="activeTab = tab.key"
            :class="[
              'px-6 py-3 text-sm font-medium transition-colors duration-200 border-b-2 -mb-[1px]',
              activeTab === tab.key
                ? 'border-campus-primary text-campus-primary'
                : 'border-transparent text-campus-text-secondary hover:text-campus-primary'
            ]"
          >{{ tab.label }}</button>
        </div>

        <!-- Tab Content -->
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
          <!-- Left: Info -->
          <div class="lg:col-span-2 space-y-6">
            <div v-for="item in currentTabItems" :key="item.id"
              class="bg-campus-surface-raised border border-campus-border rounded-xl p-6">
              <div class="flex items-start justify-between mb-3">
                <h3 class="campus-h3">{{ item.title }}</h3>
                <span class="px-3 py-1 text-xs font-semibold rounded-full"
                  :class="item.status === '招生中' ? 'bg-green-50 text-green-600' : 'bg-campus-primary-50 text-campus-primary'">{{ item.status }}</span>
              </div>
              <p class="text-sm text-campus-text-secondary leading-relaxed mb-4">{{ item.description }}</p>
              <div class="flex items-center gap-6 text-xs text-campus-text-tertiary">
                <span>计划人数：{{ item.quota }} 人</span>
                <span>学制：{{ item.duration }}</span>
                <span>报名时间：{{ item.deadline }}</span>
              </div>
            </div>
          </div>

          <!-- Right: Sidebar -->
          <div class="space-y-6">
            <div class="bg-campus-primary-50 border border-campus-primary-100 rounded-xl p-6">
              <h3 class="campus-h3 mb-3 text-campus-primary">历年分数线</h3>
              <div class="space-y-4">
                <div v-for="score in scoreLines" :key="score.year" class="flex items-center justify-between">
                  <span class="text-sm text-campus-text-secondary">{{ score.year }}</span>
                  <div class="flex gap-4">
                    <span class="text-sm font-medium">理科 {{ score.science }}</span>
                    <span class="text-sm font-medium">文科 {{ score.arts }}</span>
                  </div>
                </div>
              </div>
            </div>
            <div class="bg-campus-surface-raised border border-campus-border rounded-xl p-6">
              <h3 class="campus-h3 mb-4">常见问题</h3>
              <div class="space-y-3">
                <div v-for="faq in faqs" :key="faq.id">
                  <button @click="toggleFaq(faq.id)" class="w-full flex items-center justify-between text-left">
                    <span class="text-sm font-medium text-campus-text-primary">{{ faq.q }}</span>
                    <ChevronDown class="w-4 h-4 text-campus-text-tertiary transition-transform duration-200"
                      :class="{ 'rotate-180': openFaq === faq.id }" />
                  </button>
                  <div v-show="openFaq === faq.id" class="mt-2 text-sm text-campus-text-secondary leading-relaxed">
                    {{ faq.a }}
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Employment Section -->
    <section class="bg-campus-neutral-900 py-20 px-8">
      <div class="max-w-7xl mx-auto">
        <div class="text-center mb-14">
          <p class="campus-label text-campus-primary-300 mb-3">Career Services</p>
          <h2 class="campus-display-sm text-white mb-4">就业服务</h2>
          <p class="text-base text-campus-neutral-400 max-w-xl mx-auto leading-relaxed">全方位就业指导，助力学子扬帆起航</p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-12">
          <div v-for="item in employmentStats" :key="item.id" class="text-center">
            <div class="campus-display-sm text-campus-primary-300 mb-1">{{ item.value }}</div>
            <div class="text-sm text-campus-neutral-400">{{ item.label }}</div>
          </div>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          <div v-for="card in employmentCards" :key="card.id"
            class="bg-campus-neutral-800 border border-campus-neutral-700 rounded-xl p-6 transition-all duration-300 hover:border-campus-primary/50">
            <div class="w-10 h-10 rounded-lg bg-campus-primary/20 flex items-center justify-center mb-4">
              <component :is="card.icon" class="w-5 h-5 text-campus-primary-300" />
            </div>
            <h3 class="text-sm font-semibold text-white mb-2">{{ card.title }}</h3>
            <p class="text-xs text-campus-neutral-400 leading-relaxed">{{ card.desc }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA -->
    <section class="bg-campus-primary py-16 px-8">
      <div class="max-w-3xl mx-auto text-center">
        <h2 class="campus-display-sm text-white mb-4">准备好开始了吗？</h2>
        <p class="text-base text-white/80 leading-relaxed mb-8">立即在线申请，加入牛犇大学，开启你的人生新篇章</p>
        <div class="flex items-center justify-center gap-4 flex-wrap">
          <a href="#" class="inline-flex items-center justify-center h-12 px-8 bg-white text-campus-primary text-base font-semibold rounded-full no-underline transition-all duration-150 hover:scale-105">
            在线申请
          </a>
          <a href="#" class="inline-flex items-center justify-center h-12 px-8 bg-transparent text-white text-base font-semibold border-2 border-white/50 rounded-full no-underline transition-all duration-150 hover:border-white hover:bg-white/10">
            下载招生简章
          </a>
        </div>
      </div>
    </section>

    <FooterSection :footer-links="footerLinks" :school-info="schoolInfo" />
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { ChevronDown, GraduationCap, Briefcase, Globe, Award, BookOpen, FileText, Users, Building2, TrendingUp } from 'lucide-vue-next'
import NavBar from '../components/NavBar.vue'
import FooterSection from '../components/FooterSection.vue'
import { getNavLinks, getFooterLinks, getSchoolInfo } from '../api/campus'
import { images } from '../assets/images'

const navLinks = ref([])
const footerLinks = ref({})
const schoolInfo = ref(null)
const activeTab = ref('undergraduate')
const openFaq = ref(null)

const bannerImage = ref(images.admissionsBanner)

const quickEntries = ref([
  { id: 1, title: '本科招生', desc: '2026年招生简章', icon: GraduationCap, bgClass: 'bg-campus-primary-100', iconClass: 'text-campus-primary' },
  { id: 2, title: '研究生招生', desc: '硕士/博士申请', icon: BookOpen, bgClass: 'bg-blue-50', iconClass: 'text-blue-600' },
  { id: 3, title: '国际学生', desc: '留学生招生指南', icon: Globe, bgClass: 'bg-amber-50', iconClass: 'text-amber-600' },
  { id: 4, title: '就业信息', desc: '毕业生就业报告', icon: Briefcase, bgClass: 'bg-green-50', iconClass: 'text-green-600' }
])

const admissionTabs = [
  { key: 'undergraduate', label: '本科招生' },
  { key: 'graduate', label: '硕士招生' },
  { key: 'doctoral', label: '博士招生' }
]

const admissionItems = {
  undergraduate: [
    { id: 1, title: '2026年普通本科招生', status: '招生中', description: '面向全国 31 个省份招收本科生，涵盖 68 个专业方向，计划招生 5,200 人。实行"分数优先、遵循志愿"的录取原则。', quota: '5,200', duration: '4年', deadline: '6月25日-7月5日' },
    { id: 2, title: '强基计划招生', status: '已截止', description: '面向基础学科拔尖学生，选拔数学、物理、化学、生物、历史、哲学等方向的优秀学子，实行本硕博衔接培养。', quota: '180', duration: '4+2+3年', deadline: '4月10日-4月30日' },
    { id: 3, title: '艺术类本科招生', status: '招生中', description: '涵盖美术设计、音乐表演、舞蹈编导等方向，需参加省级艺术统考及我校校考。', quota: '350', duration: '4年', deadline: '2月15日-3月15日' }
  ],
  graduate: [
    { id: 4, title: '2026年全国硕士研究生招生', status: '招生中', description: '学术型与专业型并重，覆盖 96 个硕士点。推荐免试生和全国统考两种途径。', quota: '3,200', duration: '2-3年', deadline: '10月5日-25日' },
    { id: 5, title: '非全日制硕士招生', status: '招生中', description: '面向在职人员，MBA、MPA、教育硕士等专业方向灵活学习。', quota: '800', duration: '2.5年', deadline: '10月5日-25日' }
  ],
  doctoral: [
    { id: 6, title: '2026年博士研究生"申请-考核"制', status: '招生中', description: '面向已获得硕士学位的优秀申请者，通过材料审核和综合考核择优录取。', quota: '450', duration: '3-4年', deadline: '11月1日-30日' },
    { id: 7, title: '直博生招生', status: '已截止', description: '面向本校及"双一流"高校优秀本科毕业生，直接攻读博士学位。', quota: '120', duration: '5年', deadline: '9月1日-20日' }
  ]
}

const currentTabItems = computed(() => admissionItems[activeTab.value] || [])

const scoreLines = ref([
  { year: '2025', science: '628', arts: '601' },
  { year: '2024', science: '621', arts: '595' },
  { year: '2023', science: '615', arts: '588' }
])

const faqs = ref([
  { id: 1, q: '贵校有哪些优势专业？', a: '计算机科学、电子工程、生命科学、经济管理为我校传统优势学科，其中计算机科学和电子工程为国家"双一流"建设学科。' },
  { id: 2, q: '宿舍条件如何？', a: '本科生为四人间，配备独立卫浴、空调、热水。研究生为双人间或单人间，条件更为优越。' },
  { id: 3, q: '是否有奖学金？', a: '设有国家奖学金、校内奖学金、企业奖学金等多种类型，覆盖率达 40%。优秀新生可申请校长特别奖学金，最高 10 万元/年。' }
])

const employmentStats = ref([
  { id: 1, value: '96.8%', label: '毕业生就业率' },
  { id: 2, value: '45.2%', label: '升学深造率' },
  { id: 3, value: 'Top 500', label: '雇主企业覆盖' }
])

const employmentCards = ref([
  { id: 1, icon: Building2, title: '校园招聘会', desc: '每年举办 200+ 场名企招聘宣讲会，覆盖互联网、金融、制造等主流行业' },
  { id: 2, icon: FileText, title: '就业指导', desc: '一对一职业规划咨询、简历优化、面试辅导等全方位就业指导服务' },
  { id: 3, icon: Users, title: '校友资源', desc: '30 万+ 校友遍布全球，校友会提供职业导师和内推机会' },
  { id: 4, icon: TrendingUp, title: '创业支持', desc: '大学生创业孵化基地，提供场地、资金、导师等一站式创业扶持' }
])

const toggleFaq = (id) => {
  openFaq.value = openFaq.value === id ? null : id
}

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
      { id: 2, label: '院系设置', path: '/departments', isActive: false, sortOrder: 2 },
      { id: 3, label: '招生就业', path: '/admissions', isActive: true, sortOrder: 3 },
      { id: 4, label: '科学研究', path: '/research', isActive: false, sortOrder: 4 },
      { id: 5, label: '校园生活', path: '/campus-life', isActive: false, sortOrder: 5 },
      { id: 6, label: '新闻动态', path: '/news', isActive: false, sortOrder: 6 }
    ]
    schoolInfo.value = { name: '牛犇大学', address: '北京市海淀区学院路100号', phone: '010-62888888' }
  }
})
</script>
