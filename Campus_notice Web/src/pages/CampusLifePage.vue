<template>
  <div class="min-h-screen">
    <NavBar :nav-links="navLinks" />
    <!-- Banner -->
    <section class="relative w-full h-[320px] flex items-center justify-center overflow-hidden bg-cover bg-center"
      :style="{ backgroundImage: `url(${bannerImage})` }">
      <div class="absolute inset-0 bg-gradient-to-b from-campus-neutral-900/50 to-campus-neutral-900/70"></div>
      <div class="relative z-10 max-w-3xl px-8 text-center">
        <p class="campus-label text-campus-primary-200 mb-3">Campus Life</p>
        <h1 class="campus-display-lg text-white mb-4">校园生活</h1>
        <p class="text-base text-white/80 leading-relaxed max-w-xl mx-auto">丰富多彩的校园文化，塑造全面发展的人格</p>
      </div>
    </section>

    <!-- Life Highlights -->
    <section class="bg-campus-background py-20 px-8">
      <div class="max-w-7xl mx-auto">
        <div class="text-center mb-14">
          <p class="campus-label text-campus-primary mb-3">Vibrant Community</p>
          <h2 class="campus-display-sm mb-4">校园风采</h2>
          <p class="text-base text-campus-text-secondary max-w-xl mx-auto leading-relaxed">学术、文化、体育、公益——在这里找到属于你的精彩</p>
        </div>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          <div v-for="card in highlightCards" :key="card.id"
            class="group bg-campus-surface-raised border border-campus-border rounded-xl overflow-hidden transition-all duration-300 hover:shadow-lg hover:-translate-y-1">
            <div class="h-44 overflow-hidden">
              <img :src="card.image" :alt="card.title" class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110" />
            </div>
            <div class="p-5">
              <h3 class="campus-h3 mb-1.5">{{ card.title }}</h3>
              <p class="text-sm text-campus-text-secondary leading-relaxed">{{ card.desc }}</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Student Organizations -->
    <section class="bg-campus-surface py-20 px-8">
      <div class="max-w-7xl mx-auto">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
          <div>
            <p class="campus-label text-campus-primary mb-3">Student Organizations</p>
            <h2 class="campus-display-sm mb-6">学生社团</h2>
            <p class="text-base text-campus-text-secondary leading-relaxed mb-8">
              学校拥有 200+ 学生社团，涵盖学术科技、文化艺术、体育竞技、公益服务四大类别，
              每年举办社团招新嘉年华、社团文化节等品牌活动。
            </p>
            <div class="grid grid-cols-2 gap-4 mb-8">
              <div v-for="org in organizationCategories" :key="org.id"
                class="bg-campus-surface-raised border border-campus-border rounded-xl p-4">
                <div class="flex items-center gap-3 mb-2">
                  <div class="w-9 h-9 rounded-lg flex items-center justify-center"
                    :class="org.bgClass">
                    <component :is="org.icon" :class="org.iconClass" class="w-4 h-4" />
                  </div>
                  <span class="text-sm font-semibold">{{ org.name }}</span>
                </div>
                <span class="text-xs text-campus-text-tertiary">{{ org.count }} 个社团</span>
              </div>
            </div>
            <a href="#" class="inline-flex items-center gap-2 text-sm font-medium text-campus-primary no-underline hover:underline">
              查看全部社团 <ArrowRight class="w-4 h-4" />
            </a>
          </div>
          <div class="grid grid-cols-2 gap-4">
            <div class="space-y-4">
              <div class="rounded-2xl overflow-hidden shadow-lg">
                <img :src="orgImage1" alt="社团活动" class="w-full h-48 object-cover" />
              </div>
              <div class="rounded-2xl overflow-hidden shadow-lg">
                <img :src="orgImage2" alt="体育赛事" class="w-full h-64 object-cover" />
              </div>
            </div>
            <div class="space-y-4 pt-8">
              <div class="rounded-2xl overflow-hidden shadow-lg">
                <img :src="orgImage3" alt="文艺演出" class="w-full h-64 object-cover" />
              </div>
              <div class="rounded-2xl overflow-hidden shadow-lg">
                <img :src="orgImage4" alt="志愿服务" class="w-full h-48 object-cover" />
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Campus Facilities -->
    <section class="bg-campus-background py-20 px-8">
      <div class="max-w-7xl mx-auto">
        <div class="text-center mb-14">
          <p class="campus-label text-campus-primary mb-3">Facilities</p>
          <h2 class="campus-display-sm mb-4">校园设施</h2>
          <p class="text-base text-campus-text-secondary max-w-xl mx-auto leading-relaxed">现代化的教学与生活设施，为你的大学时光保驾护航</p>
        </div>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
          <div v-for="facility in facilities" :key="facility.id"
            class="group flex items-start gap-4 bg-campus-surface-raised border border-campus-border rounded-xl p-6 transition-all duration-300 hover:shadow-lg">
            <div class="w-12 h-12 rounded-xl flex items-center justify-center flex-shrink-0"
              :class="facility.bgClass">
              <component :is="facility.icon" :class="facility.iconClass" class="w-6 h-6" />
            </div>
            <div>
              <h3 class="campus-h3 mb-1">{{ facility.name }}</h3>
              <p class="text-sm text-campus-text-secondary leading-relaxed">{{ facility.desc }}</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Student Testimonials -->
    <section class="bg-campus-primary-50 py-20 px-8">
      <div class="max-w-7xl mx-auto">
        <div class="text-center mb-14">
          <p class="campus-label text-campus-primary mb-3">Voices</p>
          <h2 class="campus-display-sm mb-4">学子心声</h2>
        </div>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div v-for="t in testimonials" :key="t.id"
            class="bg-campus-surface-raised border border-campus-border rounded-xl p-7">
            <div class="flex items-center gap-3 mb-4">
              <div class="w-11 h-11 rounded-full bg-gradient-to-br flex items-center justify-center"
                :class="t.avatarGradient">
                <span class="text-sm text-white font-bold">{{ t.name.charAt(0) }}</span>
              </div>
              <div>
                <div class="text-sm font-semibold">{{ t.name }}</div>
                <div class="text-xs text-campus-text-tertiary">{{ t.major }} · {{ t.year }}</div>
              </div>
            </div>
            <p class="text-sm text-campus-text-secondary leading-relaxed italic">"{{ t.quote }}"</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Campus Gallery -->
    <section class="bg-campus-background py-20 px-8">
      <div class="max-w-7xl mx-auto">
        <div class="text-center mb-14">
          <p class="campus-label text-campus-primary mb-3">Gallery</p>
          <h2 class="campus-display-sm mb-4">校园掠影</h2>
        </div>
        <div class="grid grid-cols-2 md:grid-cols-4 gap-3">
          <div v-for="(img, i) in galleryImages" :key="i"
            :class="[
              'rounded-xl overflow-hidden',
              i === 0 ? 'md:col-span-2 md:row-span-2' : ''
            ]">
            <img :src="img" :alt="'校园风光' + (i + 1)" class="w-full h-full object-cover hover:scale-105 transition-transform duration-500"
              :class="i === 0 ? 'h-full' : 'h-48'" />
          </div>
        </div>
      </div>
    </section>

    <FooterSection :footer-links="footerLinks" :school-info="schoolInfo" />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ArrowRight, BookOpen, Palette, Trophy, Heart, Library, Home, Utensils, Wifi } from 'lucide-vue-next'
import NavBar from '../components/NavBar.vue'
import FooterSection from '../components/FooterSection.vue'
import { getNavLinks, getFooterLinks, getSchoolInfo } from '../api/campus'
import { images } from '../assets/images'

const navLinks = ref([])
const footerLinks = ref({})
const schoolInfo = ref(null)

const bannerImage = ref(images.campusLifeBanner)
const orgImage1 = ref(images.campusOrgFair)
const orgImage2 = ref(images.campusSports)
const orgImage3 = ref(images.campusMusic)
const orgImage4 = ref(images.campusVolunteer)

const highlightCards = ref([
  { id: 1, title: '学生社团', desc: '200+社团涵盖学术、文化、体育、公益等领域，总有适合你的舞台', image: images.campusClubs },
  { id: 2, title: '体育竞技', desc: '校级运动队 20+ 支，省级赛事多次获奖，体育精神融入校园文化', image: images.campusBasketball },
  { id: 3, title: '文化艺术', desc: '音乐节、话剧季、书法展、摄影大赛，让文艺之花绽放校园', image: images.campusArtfest },
  { id: 4, title: '志愿服务', desc: '年志愿服务超 10,000 人次，践行社会责任，传递温暖力量', image: images.campusCharity }
])

const organizationCategories = ref([
  { id: 1, name: '学术科技', count: 65, icon: BookOpen, bgClass: 'bg-blue-50', iconClass: 'text-blue-600' },
  { id: 2, name: '文化艺术', count: 52, icon: Palette, bgClass: 'bg-purple-50', iconClass: 'text-purple-600' },
  { id: 3, name: '体育竞技', count: 38, icon: Trophy, bgClass: 'bg-green-50', iconClass: 'text-green-600' },
  { id: 4, name: '公益服务', count: 45, icon: Heart, bgClass: 'bg-red-50', iconClass: 'text-red-600' }
])

const facilities = ref([
  { id: 1, name: '现代化图书馆', desc: '藏书 300 万册，24 小时自习区，智能检索系统，电子资源海量', icon: Library, bgClass: 'bg-blue-50', iconClass: 'text-blue-600' },
  { id: 2, name: '智能学生公寓', desc: '四人间标配独立卫浴、空调、热水，自助洗衣和快递驿站', icon: Home, bgClass: 'bg-green-50', iconClass: 'text-green-600' },
  { id: 3, name: '多元餐饮服务', desc: '6 个学生食堂，涵盖中西餐、清真、地方特色，价格实惠', icon: Utensils, bgClass: 'bg-amber-50', iconClass: 'text-amber-600' },
  { id: 4, name: '全校园 WiFi', desc: '5G 网络全覆盖，万兆光纤到桌面，高速稳定的网络环境', icon: Wifi, bgClass: 'bg-indigo-50', iconClass: 'text-indigo-600' },
  { id: 5, name: '综合体育馆', desc: '游泳馆、篮球馆、羽毛球馆、健身房一应俱全', icon: Trophy, bgClass: 'bg-red-50', iconClass: 'text-red-600' },
  { id: 6, name: '创新创业空间', desc: '大学生创业孵化基地，共享工位、路演厅、导师资源', icon: BookOpen, bgClass: 'bg-purple-50', iconClass: 'text-purple-600' }
])

const testimonials = ref([
  { id: 1, name: '林小琳', major: '计算机科学', year: '2024级', quote: '在这里我找到了热爱——加入机器人社团后，我从零学会了硬件编程，还和团队一起拿下了全国机器人大赛一等奖。', avatarGradient: 'from-blue-400 to-blue-600' },
  { id: 2, name: '陈志远', major: '经济管理', year: '2023级', quote: '学校给了我们很多实践机会，创业孵化基地让我把商业计划变成了真正的创业项目。校园生活的每一天都很充实。', avatarGradient: 'from-green-400 to-green-600' },
  { id: 3, name: '王思涵', major: '艺术设计', year: '2024级', quote: '我最喜欢的是校园的文艺氛围，从书法社到话剧团，每个学期都有新的惊喜。这里的图书馆也是我最爱去的地方。', avatarGradient: 'from-purple-400 to-purple-600' }
])

const galleryImages = ref([
  images.campusGarden,
  images.campusLibraryInterior,
  images.campusAutumn,
  images.campusDining,
  images.campusField
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
      { id: 4, label: '科学研究', path: '/research', isActive: false, sortOrder: 4 },
      { id: 5, label: '校园生活', path: '/campus-life', isActive: true, sortOrder: 5 },
      { id: 6, label: '新闻动态', path: '/news', isActive: false, sortOrder: 6 }
    ]
    schoolInfo.value = { name: '牛犇大学', address: '北京市海淀区学院路100号', phone: '010-62888888' }
  }
})
</script>
