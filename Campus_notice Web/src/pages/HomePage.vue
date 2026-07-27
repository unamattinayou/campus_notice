<template>
  <div class="min-h-screen">
    <NavBar :nav-links="navLinks" />
    <main>
      <HeroSection
        :hero-title="heroTitle"
        :hero-subtitle="heroSubtitle"
        :hero-image="heroImage"
      />
      <StatsSection :stats="stats" />
      <AcademicPrograms :academic-programs="academicPrograms" />
      <CampusLife
        :campus-life-features="campusLifeFeatures"
        :campus-image="campusImage"
      />
      <NewsSection :news="news" />
      <AdmissionsCTA />
    </main>
    <FooterSection :footer-links="footerLinks" :school-info="schoolInfo" />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import NavBar from '../components/NavBar.vue'
import HeroSection from '../components/HeroSection.vue'
import StatsSection from '../components/StatsSection.vue'
import AcademicPrograms from '../components/AcademicPrograms.vue'
import CampusLife from '../components/CampusLife.vue'
import NewsSection from '../components/NewsSection.vue'
import AdmissionsCTA from '../components/AdmissionsCTA.vue'
import FooterSection from '../components/FooterSection.vue'
import { getHomePageData } from '../api/campus'
import { images } from '../assets/images'

const navLinks = ref([])
const stats = ref([])
const academicPrograms = ref([])
const campusLifeFeatures = ref([])
const news = ref([])
const footerLinks = ref({})
const schoolInfo = ref(null)

const heroTitle = ref('在这里，遇见未来')
const heroSubtitle = ref('探索知识的边界，成就卓越的人生')
const heroImage = ref(images.heroCampus)
const campusImage = ref(images.campusLibrary)

onMounted(async () => {
  try {
    const response = await getHomePageData()
    if (response.data.success && response.data.data) {
      const data = response.data.data
      navLinks.value = data.navLinks || []
      stats.value = data.stats || []
      academicPrograms.value = data.academicPrograms || []
      campusLifeFeatures.value = data.campusLifeFeatures || []
      news.value = data.news || []
      footerLinks.value = data.footerLinks || {}
      schoolInfo.value = data.schoolInfo || null
    }
  } catch (error) {
    console.error('Failed to fetch home page data:', error)
    loadMockData()
  }
})

const loadMockData = () => {
  navLinks.value = [
    { id: 1, label: '首页', path: '/', isActive: true, sortOrder: 1 },
    { id: 2, label: '院系设置', path: '/departments', isActive: false, sortOrder: 2 },
    { id: 3, label: '招生就业', path: '/admissions', isActive: false, sortOrder: 3 },
    { id: 4, label: '科学研究', path: '/research', isActive: false, sortOrder: 4 },
    { id: 5, label: '校园生活', path: '/campus-life', isActive: false, sortOrder: 5 },
    { id: 6, label: '新闻动态', path: '/news', isActive: false, sortOrder: 6 }
  ]
  stats.value = [
    { id: 1, statKey: 'history_years', statValue: '70', statLabel: '年办学历史' },
    { id: 2, statKey: 'student_count', statValue: '35000', statLabel: '在校学生' },
    { id: 3, statKey: 'faculty_count', statValue: '2800', statLabel: '教职员工' },
    { id: 4, statKey: 'degree_programs', statValue: '156', statLabel: '硕博学位点' }
  ]
  academicPrograms.value = [
    { id: 1, code: 'CS', name: '计算机科学', description: '聚焦人工智能、大数据与软件工程，培养面向未来的技术创新人才' },
    { id: 2, code: 'EM', name: '经济管理', description: '融合经济学与管理学前沿理论，注重实践与国际化视野' },
    { id: 3, code: 'LC', name: '文学与传播', description: '传承人文精神，在数字时代探索文学创作与传媒创新' },
    { id: 4, code: 'LS', name: '生命科学', description: '从基因到生态，探索生命奥秘，推动生物医药前沿突破' },
    { id: 5, code: 'ET', name: '工程技术', description: '涵盖土木、机械、电子等多个方向，产学研深度融合' },
    { id: 6, code: 'AD', name: '艺术设计', description: '融合传统美学与现代设计理念，激发创造力与审美表达' }
  ]
  campusLifeFeatures.value = [
    { id: 1, title: '学生社团', description: '200+社团涵盖学术、文化、体育、公益等领域' },
    { id: 2, title: '体育竞技', description: '省级赛事多次获奖，体育精神融入校园文化' },
    { id: 3, title: '志愿服务', description: '参与公益项目，践行社会责任，传递温暖力量' }
  ]
  news.value = [
    { id: 1, title: '我校科研团队获国家重点研发计划立项', summary: '计算机科学与生命科学交叉研究团队成功获批国家重点研发计划项目，将在人工智能辅助药物发现领域展开深入探索。', category: '学术', publishDate: '2026-07-10' },
    { id: 2, title: '第十二届校园文化艺术节圆满落幕', summary: '历时两周的校园文化艺术节吸引了近万名师生参与，涵盖音乐、戏剧、书法、摄影等多个板块，展现了明德学子的多元才华。', category: '校园', publishDate: '2026-07-05' },
    { id: 3, title: '2026年秋季学期开学安排公告', summary: '2026年秋季学期将于9月1日正式开学，新生报到时间为8月28日至30日，请各位同学做好相关准备。', category: '通知', publishDate: '2026-06-28' }
  ]
  footerLinks.value = {
    '快速链接': [
      { id: 1, section: '快速链接', label: '院系设置', path: '/departments', sortOrder: 1 },
      { id: 2, section: '快速链接', label: '科学研究', path: '/research', sortOrder: 2 },
      { id: 3, section: '快速链接', label: '校园生活', path: '/campus-life', sortOrder: 3 },
      { id: 4, section: '快速链接', label: '新闻动态', path: '/news', sortOrder: 4 }
    ],
    '招生信息': [
      { id: 5, section: '招生信息', label: '本科招生', path: '/undergraduate', sortOrder: 1 },
      { id: 6, section: '招生信息', label: '研究生招生', path: '/graduate', sortOrder: 2 },
      { id: 7, section: '招生信息', label: '国际学生', path: '/international', sortOrder: 3 },
      { id: 8, section: '招生信息', label: '奖学金', path: '/scholarships', sortOrder: 4 }
    ],
    '联系我们': [
      { id: 9, section: '联系我们', label: '招生咨询', path: '/contact', sortOrder: 1 },
      { id: 10, section: '联系我们', label: '校园访问', path: '/visit', sortOrder: 2 },
      { id: 11, section: '联系我们', label: '信息公开', path: '/public', sortOrder: 3 },
      { id: 12, section: '联系我们', label: '校友会', path: '/alumni', sortOrder: 4 }
    ]
  }
  schoolInfo.value = { id: 1, name: '牛犇大学', address: '北京市海淀区学院路100号', postalCode: '100081', phone: '010-62888888' }
}
</script>
