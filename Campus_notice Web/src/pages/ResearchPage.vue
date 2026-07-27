<template>
  <div class="min-h-screen">
    <NavBar :nav-links="navLinks" />
    <!-- Banner -->
    <section class="relative w-full h-[320px] flex items-center justify-center overflow-hidden bg-cover bg-center"
      :style="{ backgroundImage: `url(${bannerImage})` }">
      <div class="absolute inset-0 bg-gradient-to-b from-campus-neutral-900/50 to-campus-neutral-900/70"></div>
      <div class="relative z-10 max-w-3xl px-8 text-center">
        <p class="campus-label text-campus-primary-200 mb-3">Scientific Research</p>
        <h1 class="campus-display-lg text-white mb-4">科学研究</h1>
        <p class="text-base text-white/80 leading-relaxed max-w-xl mx-auto">面向国家战略需求，推动基础研究与应用创新深度融合</p>
      </div>
    </section>

    <!-- Research Stats -->
    <section class="bg-campus-surface py-10 px-8">
      <div class="max-w-7xl mx-auto grid grid-cols-2 md:grid-cols-4 gap-6">
        <div v-for="stat in researchStats" :key="stat.id" class="text-center">
          <div class="campus-display-sm text-campus-primary mb-1">{{ stat.value }}</div>
          <div class="text-sm text-campus-text-secondary">{{ stat.label }}</div>
        </div>
      </div>
    </section>

    <!-- Research Platforms -->
    <section class="bg-campus-background py-20 px-8">
      <div class="max-w-7xl mx-auto">
        <div class="text-center mb-14">
          <p class="campus-label text-campus-primary mb-3">Research Platforms</p>
          <h2 class="campus-display-sm mb-4">科研平台</h2>
          <p class="text-base text-campus-text-secondary max-w-xl mx-auto leading-relaxed">国家级、省部级科研平台构筑创新高地</p>
        </div>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <div v-for="platform in platforms" :key="platform.id"
            class="bg-campus-surface-raised border border-campus-border rounded-xl p-7 transition-all duration-300 hover:shadow-lg hover:-translate-y-1">
            <div class="flex items-center gap-3 mb-4">
              <div class="w-10 h-10 rounded-lg flex items-center justify-center"
                :class="platform.bgClass">
                <component :is="platform.icon" :class="platform.iconClass" class="w-5 h-5" />
              </div>
              <span class="px-2.5 py-0.5 text-xs font-semibold rounded-full"
                :class="platform.levelClass">{{ platform.level }}</span>
            </div>
            <h3 class="campus-h3 mb-2">{{ platform.name }}</h3>
            <p class="text-sm text-campus-text-secondary leading-relaxed mb-4">{{ platform.description }}</p>
            <div class="flex items-center gap-4 text-xs text-campus-text-tertiary">
              <span>{{ platform.director }}</span>
              <span>{{ platform.members }} 名研究人员</span>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Research Areas -->
    <section class="bg-campus-primary-50 py-20 px-8">
      <div class="max-w-7xl mx-auto">
        <div class="text-center mb-14">
          <p class="campus-label text-campus-primary mb-3">Research Areas</p>
          <h2 class="campus-display-sm mb-4">重点研究领域</h2>
        </div>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
          <div v-for="area in researchAreas" :key="area.id"
            class="group flex gap-5 bg-campus-surface-raised border border-campus-border rounded-xl p-7 transition-all duration-300 hover:shadow-lg">
            <div class="w-14 h-14 rounded-xl bg-gradient-to-br flex items-center justify-center flex-shrink-0"
              :class="area.gradient">
              <span class="text-xl text-white font-bold">{{ area.icon }}</span>
            </div>
            <div>
              <h3 class="campus-h3 mb-1.5">{{ area.name }}</h3>
              <p class="text-sm text-campus-text-secondary leading-relaxed mb-3">{{ area.description }}</p>
              <div class="flex flex-wrap gap-2">
                <span v-for="tag in area.tags" :key="tag"
                  class="px-2.5 py-0.5 bg-campus-surface text-xs text-campus-text-tertiary rounded-full">{{ tag }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Achievements Timeline -->
    <section class="bg-campus-background py-20 px-8">
      <div class="max-w-4xl mx-auto">
        <div class="text-center mb-14">
          <p class="campus-label text-campus-primary mb-3">Achievements</p>
          <h2 class="campus-display-sm mb-4">科研亮点</h2>
        </div>
        <div class="relative pl-8 border-l-2 border-campus-primary-200 space-y-10">
          <div v-for="item in achievements" :key="item.id" class="relative">
            <div class="absolute -left-[41px] w-5 h-5 rounded-full bg-campus-primary border-4 border-campus-primary-100"></div>
            <div class="bg-campus-surface-raised border border-campus-border rounded-xl p-6">
              <div class="flex items-center gap-3 mb-2">
                <span class="text-xs font-semibold text-campus-primary">{{ item.date }}</span>
                <span class="px-2 py-0.5 text-xs font-medium rounded-full"
                  :class="item.type === '论文' ? 'bg-blue-50 text-blue-600' : item.type === '项目' ? 'bg-green-50 text-green-600' : 'bg-amber-50 text-amber-600'">{{ item.type }}</span>
              </div>
              <h3 class="campus-h3 mb-1.5">{{ item.title }}</h3>
              <p class="text-sm text-campus-text-secondary leading-relaxed">{{ item.description }}</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Research Team -->
    <section class="bg-campus-neutral-900 py-20 px-8">
      <div class="max-w-7xl mx-auto">
        <div class="text-center mb-14">
          <p class="campus-label text-campus-primary-300 mb-3">Our Team</p>
          <h2 class="campus-display-sm text-white mb-4">科研团队</h2>
          <p class="text-base text-campus-neutral-400 max-w-xl mx-auto leading-relaxed">汇聚顶尖学者，引领科研创新</p>
        </div>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
          <div v-for="member in teamMembers" :key="member.id"
            class="bg-campus-neutral-800 border border-campus-neutral-700 rounded-xl p-6 text-center transition-all duration-300 hover:border-campus-primary/50">
            <div class="w-20 h-20 rounded-full bg-gradient-to-br from-campus-primary-300 to-campus-primary-500 mx-auto mb-4 flex items-center justify-center">
              <span class="text-2xl text-white font-bold">{{ member.name.charAt(0) }}</span>
            </div>
            <h3 class="text-sm font-semibold text-white mb-1">{{ member.name }}</h3>
            <p class="text-xs text-campus-primary-300 mb-1">{{ member.title }}</p>
            <p class="text-xs text-campus-neutral-400">{{ member.field }}</p>
          </div>
        </div>
      </div>
    </section>

    <FooterSection :footer-links="footerLinks" :school-info="schoolInfo" />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { FlaskConical, Cpu, Heart, Atom, Globe, Palette } from 'lucide-vue-next'
import NavBar from '../components/NavBar.vue'
import FooterSection from '../components/FooterSection.vue'
import { getNavLinks, getFooterLinks, getSchoolInfo } from '../api/campus'
import { images } from '../assets/images'

const navLinks = ref([])
const footerLinks = ref({})
const schoolInfo = ref(null)

const bannerImage = ref(images.researchBanner)

const researchStats = ref([
  { id: 1, value: '6', label: '国家级科研平台' },
  { id: 2, value: '28', label: '省部级科研平台' },
  { id: 3, value: '1,200+', label: '年度 SCI 论文' },
  { id: 4, value: '8.5亿', label: '年度科研经费' }
])

const platforms = ref([
  { id: 1, name: '人工智能与大数据国家重点实验室', level: '国家级', levelClass: 'bg-red-50 text-red-600', description: '聚焦机器学习、计算机视觉、自然语言处理等基础理论突破与产业应用', director: '张明远 教授', members: 85, icon: Cpu, bgClass: 'bg-blue-50', iconClass: 'text-blue-600' },
  { id: 2, name: '生物医药交叉创新中心', level: '省部级', levelClass: 'bg-campus-primary-50 text-campus-primary', description: '推动 AI 赋能药物发现、基因编辑和精准医疗领域的交叉创新研究', director: '李文华 教授', members: 62, icon: Heart, bgClass: 'bg-red-50', iconClass: 'text-red-600' },
  { id: 3, name: '先进材料与绿色能源研究院', level: '省部级', levelClass: 'bg-campus-primary-50 text-campus-primary', description: '在新型功能材料、固态电池、光伏器件等方向取得系列突破', director: '王建国 教授', members: 48, icon: Atom, bgClass: 'bg-amber-50', iconClass: 'text-amber-600' },
  { id: 4, name: '智慧城市与数字治理研究中心', level: '省部级', levelClass: 'bg-campus-primary-50 text-campus-primary', description: '利用大数据和 AI 技术推动城市治理现代化与数字化转型', director: '陈思远 教授', members: 35, icon: Globe, bgClass: 'bg-green-50', iconClass: 'text-green-600' },
  { id: 5, name: '文化创意与数字媒体实验室', level: '校级', levelClass: 'bg-gray-100 text-gray-600', description: '探索传统文化数字化保护与数字媒体内容创新', director: '刘雅婷 教授', members: 22, icon: Palette, bgClass: 'bg-purple-50', iconClass: 'text-purple-600' },
  { id: 6, name: '生物多样性与生态修复研究所', level: '省部级', levelClass: 'bg-campus-primary-50 text-campus-primary', description: '聚焦濒危物种保护、生态系统修复和可持续发展研究', director: '赵文博 教授', members: 30, icon: FlaskConical, bgClass: 'bg-teal-50', iconClass: 'text-teal-600' }
])

const researchAreas = ref([
  { id: 1, name: '人工智能与机器学习', description: '在深度学习理论、大语言模型、计算机视觉等方向持续产出高水平成果，多篇论文入选 NeurIPS、CVPR、ACL 等顶级会议。', icon: 'AI', gradient: 'from-blue-500 to-blue-700', tags: ['深度学习', 'NLP', '计算机视觉', '强化学习'] },
  { id: 2, name: '生物医药工程', description: '利用 AI 技术加速药物发现，在蛋白质结构预测、分子对接等方向取得重要进展，与多家药企开展合作研究。', icon: 'BP', gradient: 'from-red-500 to-red-700', tags: ['药物发现', '基因编辑', '精准医疗', '生物信息'] },
  { id: 3, name: '新能源与先进材料', description: '在钙钛矿太阳能电池、固态电解质、碳纳米材料等领域拥有多项核心专利，推动产业化转化。', icon: 'EM', gradient: 'from-amber-500 to-amber-700', tags: ['太阳能电池', '储能材料', '纳米技术', '绿色化学'] },
  { id: 4, name: '数字经济与社会治理', description: '运用大数据分析方法研究数字经济运行规律与社会治理创新模式，为政策制定提供智力支撑。', icon: 'DG', gradient: 'from-green-500 to-green-700', tags: ['数字经济', '数据治理', '智慧城市', '公共政策'] }
])

const achievements = ref([
  { id: 1, date: '2026-06', type: '论文', title: 'Nature 发文：AI 辅助药物筛选新方法', description: '计算机科学与生命科学交叉研究团队在 Nature 主刊发表研究论文，提出基于图神经网络的小分子药物筛选新方法，效率提升 50 倍。' },
  { id: 2, date: '2026-03', type: '项目', title: '获批国家重点研发计划项目', description: '人工智能与大数据国家重点实验室成功获批国家重点研发计划项目，资助经费 3,200 万元。' },
  { id: 3, date: '2025-12', type: '奖项', title: '国家科技进步二等奖', description: '先进材料团队凭借"高性能钙钛矿太阳能电池关键技术"项目荣获国家科技进步二等奖。' },
  { id: 4, date: '2025-09', type: '论文', title: 'Science 发文：量子计算新突破', description: '物理与材料科学交叉团队在 Science 发表论文，实现了 128 量子比特的稳定纠缠态。' }
])

const teamMembers = ref([
  { id: 1, name: '张明远', title: '中国科学院院士', field: '人工智能与机器学习' },
  { id: 2, name: '李文华', title: '国家杰出青年基金获得者', field: '生物医药工程' },
  { id: 3, name: '王建国', title: '长江学者特聘教授', field: '新能源与先进材料' },
  { id: 4, name: '陈思远', title: '国家优秀青年基金获得者', field: '数字经济与社会治理' }
])

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
      { id: 3, label: '招生就业', path: '/admissions', isActive: false, sortOrder: 3 },
      { id: 4, label: '科学研究', path: '/research', isActive: true, sortOrder: 4 },
      { id: 5, label: '校园生活', path: '/campus-life', isActive: false, sortOrder: 5 },
      { id: 6, label: '新闻动态', path: '/news', isActive: false, sortOrder: 6 }
    ]
    schoolInfo.value = { name: '牛犇大学', address: '北京市海淀区学院路100号', phone: '010-62888888' }
  }
})
</script>
