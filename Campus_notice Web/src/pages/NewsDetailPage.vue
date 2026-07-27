<template>
  <div class="min-h-screen">
    <NavBar :nav-links="navLinks" />

    <!-- Article Hero Section -->
    <section class="relative w-full h-[280px] md:h-[400px] overflow-hidden"
      :class="hasImage ? 'bg-campus-neutral-800' : 'bg-gradient-to-br from-campus-primary to-campus-primary-700'">
      <img v-if="hasImage" :src="currentImage" :alt="newsDetail?.title" class="w-full h-full object-cover" />
      <div v-else class="absolute inset-0 flex items-center justify-center">
        <div class="text-center text-white/30">
          <FileText class="w-16 h-16 mx-auto mb-3" />
          <p class="text-sm">新闻公告</p>
        </div>
      </div>
      <div class="absolute inset-0 bg-gradient-to-t from-campus-neutral-900/80 via-campus-neutral-900/30 to-transparent"></div>
      <div class="absolute bottom-0 left-0 right-0 p-8 md:p-12 max-w-4xl mx-auto">
        <!-- Breadcrumb -->
        <nav class="flex items-center gap-2 text-xs text-white/60 mb-4">
          <router-link to="/" class="hover:text-white/90 no-underline text-white/60">首页</router-link>
          <span>/</span>
          <router-link to="/news" class="hover:text-white/90 no-underline text-white/60">新闻动态</router-link>
          <span>/</span>
          <span class="text-white/80">{{ newsDetail?.category || '详情' }}</span>
        </nav>
        <!-- Category Badge -->
        <span class="px-3 py-1 text-xs font-semibold rounded-full"
          :class="getCategoryClass(newsDetail?.category)">{{ newsDetail?.category || '新闻' }}</span>
        <!-- Title -->
        <h1 class="campus-display-md text-white mt-3 mb-3 leading-tight">{{ newsDetail?.title || '加载中...' }}</h1>
        <!-- Meta -->
        <div class="flex items-center gap-4 text-sm text-white/70 flex-wrap">
          <div class="flex items-center gap-2">
            <div class="w-7 h-7 rounded-full bg-campus-primary flex items-center justify-center">
              <span class="text-xs text-white font-bold">{{ authorName?.charAt(0) || '编' }}</span>
            </div>
            <span>{{ newsDetail?.author || authorName || '牛犇大学新闻中心' }}</span>
          </div>
          <span>{{ newsDetail?.publishDate }}</span>
          <span class="flex items-center gap-1">
            <Eye class="w-3.5 h-3.5" /> {{ newsDetail?.viewCount || viewCount }}
          </span>
        </div>
      </div>
    </section>

    <!-- Article Body -->
    <section class="bg-campus-background py-12 px-8">
      <div class="max-w-4xl mx-auto">
        <div class="grid grid-cols-1 lg:grid-cols-[1fr_280px] gap-10">
          <!-- Main Content -->
          <article class="min-w-0">
            <!-- Article Card -->
            <div class="bg-campus-surface-raised border border-campus-border rounded-2xl overflow-hidden">
              <!-- Lead Summary -->
              <div class="px-8 lg:px-10 pt-8">
                <p class="text-lg text-campus-text-secondary leading-relaxed border-l-4 border-campus-primary pl-5 italic">
                  {{ newsDetail?.summary || '' }}
                </p>
              </div>

              <!-- Article Content -->
              <div class="px-8 lg:px-10 py-8">
                <div class="article-content">
                  <template v-if="newsDetail?.content">
                    <div v-for="(paragraph, index) in contentParagraphs" :key="index"
                      :class="paragraph.type === 'heading' ? 'mb-6' : 'mb-5'">
                      <h2 v-if="paragraph.type === 'heading'" class="campus-h2 mb-2">{{ paragraph.text }}</h2>
                      <p v-else class="text-base text-campus-text-secondary leading-loose">{{ paragraph.text }}</p>
                    </div>
                    <!-- Inline image -->
                    <div v-if="hasImage" class="my-8 rounded-xl overflow-hidden shadow-md">
                      <img :src="currentImage" :alt="newsDetail?.title" class="w-full h-auto" />
                      <p class="text-xs text-campus-text-tertiary mt-2 text-center">{{ newsDetail?.imageCaption || '' }}</p>
                    </div>
                    <!-- Remaining paragraphs -->
                    <div v-for="(paragraph, index) in remainingParagraphs" :key="'r-' + index"
                      :class="paragraph.type === 'heading' ? 'mb-6' : 'mb-5'">
                      <h2 v-if="paragraph.type === 'heading'" class="campus-h2 mb-2">{{ paragraph.text }}</h2>
                      <p v-else class="text-base text-campus-text-secondary leading-loose">{{ paragraph.text }}</p>
                    </div>
                  </template>
                  <p v-else class="text-base text-campus-text-secondary leading-loose">
                    {{ newsDetail?.summary || '暂无正文内容' }}
                  </p>
                </div>
              </div>

              <!-- Tags -->
              <div v-if="currentTags.length" class="px-8 lg:px-10 pb-8">
                <div class="pt-6 border-t border-campus-border">
                  <div class="flex items-center gap-2 flex-wrap">
                    <Tag class="w-4 h-4 text-campus-text-tertiary" />
                    <span v-for="tag in currentTags" :key="tag"
                      class="px-3 py-1 bg-campus-surface text-xs text-campus-text-tertiary rounded-full hover:text-campus-primary hover:bg-campus-primary-50 transition-colors cursor-pointer">
                      {{ tag }}
                    </span>
                  </div>
                </div>
              </div>

              <!-- Actions Bar -->
              <div class="px-8 lg:px-10 py-5 bg-campus-surface border-t border-campus-border flex items-center justify-between">
                <div class="flex items-center gap-3">
                  <button @click="handleLike"
                    :class="[
                      'flex items-center gap-1.5 px-4 py-2 rounded-lg text-sm font-medium transition-all duration-200',
                      isLiked ? 'bg-red-50 text-red-500' : 'bg-campus-surface-raised text-campus-text-secondary hover:bg-campus-primary-50 hover:text-campus-primary'
                    ]">
                    <Heart :class="['w-4 h-4', isLiked ? 'fill-current' : '']" />
                    {{ likeCount }}
                  </button>
                  <button @click="handleShare"
                    class="flex items-center gap-1.5 px-4 py-2 rounded-lg text-sm font-medium bg-campus-surface-raised text-campus-text-secondary hover:bg-campus-primary-50 hover:text-campus-primary transition-all duration-200">
                    <Share2 class="w-4 h-4" />
                    分享
                  </button>
                  <button @click="handleBookmark"
                    :class="[
                      'flex items-center gap-1.5 px-4 py-2 rounded-lg text-sm font-medium transition-all duration-200',
                      isBookmarked ? 'bg-amber-50 text-amber-500' : 'bg-campus-surface-raised text-campus-text-secondary hover:bg-campus-primary-50 hover:text-campus-primary'
                    ]">
                    <Bookmark :class="['w-4 h-4', isBookmarked ? 'fill-current' : '']" />
                    收藏
                  </button>
                </div>
                <div class="flex items-center gap-2">
                  <button @click="handleFontSize('decrease')" class="w-8 h-8 flex items-center justify-center rounded-lg bg-campus-surface-raised text-campus-text-secondary hover:bg-campus-primary-50 hover:text-campus-primary transition-colors text-xs font-bold">
                    A-
                  </button>
                  <span class="text-xs text-campus-text-tertiary w-8 text-center">{{ fontSizeLabel }}</span>
                  <button @click="handleFontSize('increase')" class="w-8 h-8 flex items-center justify-center rounded-lg bg-campus-surface-raised text-campus-text-secondary hover:bg-campus-primary-50 hover:text-campus-primary transition-colors text-sm font-bold">
                    A+
                  </button>
                </div>
              </div>

              <!-- Attachment -->
              <div v-if="newsDetail?.attachmentUrl" class="px-8 lg:px-10 py-5 bg-campus-surface-raised border-t border-campus-border">
                <div class="flex items-center gap-3">
                  <div class="w-10 h-10 rounded-lg bg-campus-primary-50 flex items-center justify-center">
                    <FileDown class="w-5 h-5 text-campus-primary" />
                  </div>
                  <div>
                    <a :href="newsDetail.attachmentUrl" target="_blank"
                      class="text-sm font-medium text-campus-primary no-underline hover:underline">下载附件</a>
                    <p class="text-xs text-campus-text-tertiary">点击下载相关文件</p>
                  </div>
                </div>
              </div>
            </div>

            <!-- Author Box -->
            <div v-if="newsDetail?.author" class="mt-8 bg-campus-surface-raised border border-campus-border rounded-xl p-6 flex items-center gap-5">
              <div class="w-14 h-14 rounded-full bg-gradient-to-br from-campus-primary-300 to-campus-primary-500 flex items-center justify-center flex-shrink-0">
                <span class="text-xl text-white font-bold">{{ newsDetail.author.charAt(0) }}</span>
              </div>
              <div class="min-w-0">
                <div class="campus-h3 mb-0.5">{{ newsDetail.author }}</div>
                <p class="text-sm text-campus-text-secondary leading-relaxed line-clamp-2">
                  {{ newsDetail.authorBio || '牛犇大学新闻中心编辑，负责校园新闻采编与发布工作。' }}
                </p>
              </div>
            </div>

            <!-- Prev / Next Navigation -->
            <div class="mt-8 grid grid-cols-1 md:grid-cols-2 gap-4">
              <router-link v-if="prevNews" :to="`/news/${prevNews.id}`"
                class="group flex items-start gap-4 bg-campus-surface-raised border border-campus-border rounded-xl p-5 no-underline transition-all hover:shadow-md hover:-translate-y-0.5">
                <div class="flex-shrink-0 mt-0.5">
                  <ChevronLeft class="w-5 h-5 text-campus-text-tertiary group-hover:text-campus-primary transition-colors" />
                </div>
                <div class="min-w-0">
                  <span class="text-xs text-campus-text-tertiary">上一篇</span>
                  <p class="text-sm font-medium text-campus-text-primary line-clamp-2 mt-0.5">{{ prevNews.title }}</p>
                </div>
              </router-link>
              <div v-else></div>
              <router-link v-if="nextNews" :to="`/news/${nextNews.id}`"
                class="group flex items-start gap-4 bg-campus-surface-raised border border-campus-border rounded-xl p-5 no-underline text-right transition-all hover:shadow-md hover:-translate-y-0.5">
                <div class="flex-1 min-w-0">
                  <span class="text-xs text-campus-text-tertiary">下一篇</span>
                  <p class="text-sm font-medium text-campus-text-primary line-clamp-2 mt-0.5">{{ nextNews.title }}</p>
                </div>
                <div class="flex-shrink-0 mt-0.5">
                  <ChevronRight class="w-5 h-5 text-campus-text-tertiary group-hover:text-campus-primary transition-colors" />
                </div>
              </router-link>
              <div v-else></div>
            </div>

            <!-- Back to List -->
            <div class="mt-8 text-center">
              <button @click="$router.push('/news')"
                class="inline-flex items-center gap-2 px-6 py-2.5 rounded-full bg-campus-surface border border-campus-border text-sm font-medium text-campus-text-secondary hover:bg-campus-primary hover:text-white hover:border-campus-primary transition-all duration-200">
                <ArrowLeft class="w-4 h-4" />
                返回新闻列表
              </button>
            </div>
          </article>

          <!-- Sidebar -->
          <aside class="hidden lg:block">
            <!-- Share Card -->
            <div class="bg-campus-surface-raised border border-campus-border rounded-xl p-6 mb-6 sticky top-24">
              <h3 class="campus-h3 mb-4">分享文章</h3>
              <div class="grid grid-cols-3 gap-3">
                <button @click="shareToSocial('wechat')" class="flex flex-col items-center gap-1.5 p-3 rounded-lg bg-campus-surface hover:bg-green-50 transition-colors">
                  <MessageCircle class="w-5 h-5 text-green-500" />
                  <span class="text-xs text-campus-text-tertiary">微信</span>
                </button>
                <button @click="shareToSocial('weibo')" class="flex flex-col items-center gap-1.5 p-3 rounded-lg bg-campus-surface hover:bg-red-50 transition-colors">
                  <AtSign class="w-5 h-5 text-red-500" />
                  <span class="text-xs text-campus-text-tertiary">微博</span>
                </button>
                <button @click="shareToSocial('qq')" class="flex flex-col items-center gap-1.5 p-3 rounded-lg bg-campus-surface hover:bg-blue-50 transition-colors">
                  <MessageSquare class="w-5 h-5 text-blue-500" />
                  <span class="text-xs text-campus-text-tertiary">QQ</span>
                </button>
                <button @click="shareToSocial('link')" class="flex flex-col items-center gap-1.5 p-3 rounded-lg bg-campus-surface hover:bg-campus-primary-50 transition-colors">
                  <Link class="w-5 h-5 text-campus-primary" />
                  <span class="text-xs text-campus-text-tertiary">复制链接</span>
                </button>
              </div>
            </div>

            <!-- Related News -->
            <div class="bg-campus-surface-raised border border-campus-border rounded-xl p-6 mb-6">
              <h3 class="campus-h3 mb-4">相关新闻</h3>
              <div class="space-y-4">
                <router-link v-for="item in relatedNews" :key="item.id" :to="`/news/${item.id}`"
                  class="group block no-underline">
                  <div class="flex items-start gap-3">
                    <img :src="item.image" :alt="item.title"
                      class="w-16 h-12 rounded-lg object-cover flex-shrink-0" />
                    <div class="min-w-0">
                      <p class="text-sm font-medium text-campus-text-primary line-clamp-2 group-hover:text-campus-primary transition-colors">{{ item.title }}</p>
                      <span class="text-xs text-campus-text-tertiary mt-1">{{ item.publishDate }}</span>
                    </div>
                  </div>
                </router-link>
              </div>
            </div>

            <!-- Hot Tags -->
            <div class="bg-campus-surface-raised border border-campus-border rounded-xl p-6">
              <h3 class="campus-h3 mb-4">热门标签</h3>
              <div class="flex flex-wrap gap-2">
                <span v-for="tag in hotTags" :key="tag"
                  class="px-3 py-1.5 bg-campus-surface text-xs text-campus-text-secondary rounded-full hover:bg-campus-primary-50 hover:text-campus-primary transition-colors cursor-pointer">
                  #{{ tag }}
                </span>
              </div>
            </div>
          </aside>
        </div>
      </div>
    </section>

    <!-- Not Found State -->
    <div v-if="!newsDetail && !loading" class="bg-campus-background py-32 px-8">
      <div class="max-w-md mx-auto text-center">
        <AlertCircle class="w-16 h-16 text-campus-text-tertiary mx-auto mb-4" />
        <h2 class="campus-h1 mb-2">文章未找到</h2>
        <p class="text-sm text-campus-text-secondary mb-6">您访问的新闻不存在或已被删除</p>
        <button @click="$router.push('/news')"
          class="inline-flex items-center gap-2 px-6 py-3 bg-campus-primary text-white text-sm font-semibold rounded-full hover:bg-campus-primary-dark transition-colors">
          <ArrowLeft class="w-4 h-4" />
          返回新闻列表
        </button>
      </div>
    </div>

    <FooterSection :footer-links="footerLinks" :school-info="schoolInfo" />
  </div>
</template>

<script setup>
import { ref, computed, watch, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import {
  ArrowLeft, ChevronLeft, ChevronRight, Heart, Share2, Bookmark,
  Eye, Tag, FileDown, AlertCircle, MessageCircle, AtSign,
  MessageSquare, Link, Copy
} from 'lucide-vue-next'
import NavBar from '../components/NavBar.vue'
import FooterSection from '../components/FooterSection.vue'
import { getNavLinks, getFooterLinks, getSchoolInfo, getNewsById } from '../api/campus'
import { images } from '../assets/images'

const route = useRoute()
const router = useRouter()

const navLinks = ref([])
const footerLinks = ref({})
const schoolInfo = ref(null)
const newsDetail = ref(null)
const loading = ref(true)

const isLiked = ref(false)
const isBookmarked = ref(false)
const likeCount = ref(42)
const viewCount = ref(1286)
const authorName = ref('牛犇大学新闻中心')
const fontSize = ref(16) // 14, 16, 18

// All news data for navigation & related
const allNewsData = ref([
  {
    id: 0, title: '我校计算机科学学科进入 ESI 全球前 1%',
    summary: '根据科睿唯安最新发布的 ESI 数据，我校计算机科学学科首次进入全球前 1%，标志着该学科的国际影响力迈上新台阶。近年来，学校大力加强学科建设，引进了一批高层次人才，科研实力持续提升。',
    category: '学术', publishDate: '2026-07-15', image: images.newsFeatured,
    author: '张晓明', authorBio: '牛犇大学新闻中心高级编辑，负责学术科研类新闻报道。',
    tags: ['学科建设', 'ESI', '计算机科学', '双一流'],
    content: '根据科睿唯安（Clarivate Analytics）2026年7月发布的最新 ESI（Essential Science Indicators）数据，我校计算机科学学科首次进入全球前 1%，标志着该学科的国际学术影响力迈上了新的台阶。\n\n这一里程碑式的突破，是学校近年来大力实施"学科振兴计划"的重要成果。自2020年起，学校先后出台了一系列学科建设支持政策，引进了包括中国科学院院士张明远教授在内的30余位高层次人才，建设了人工智能与大数据国家重点实验室等高水平科研平台。\n\n数据显示，过去五年间，我校计算机科学领域在高影响力期刊上发表论文超过600篇，其中 Nature、Science 子刊论文12篇，被引频次超过15,000次。此外，该学科在 US News 2026 世界大学学科排名中位列全球第 78 位，在国内高校中排名前 15。\n\n校长在接受采访时表示："计算机科学学科进入 ESI 全球前 1%，是学校学科建设的重要里程碑。学校将继续加大投入力度，力争在更多学科领域实现突破，全面提升学校的国际竞争力和学术影响力。"\n\n据悉，学校下一步将重点推进人工智能与生物医药、新材料等学科的交叉融合，打造具有国际影响力的跨学科研究高地。',
    contentImage: images.newsResearch,
    contentImageCaption: '科研团队在人工智能实验室进行算法研究与模型训练'
  },
  {
    id: 1, title: '我校科研团队获国家重点研发计划立项',
    summary: '计算机科学与生命科学交叉研究团队成功获批国家重点研发计划项目，将在人工智能辅助药物发现领域展开深入探索。',
    category: '学术', publishDate: '2026-07-10', image: images.newsResearch,
    author: '李文博', authorBio: '科研新闻编辑，专注报道学校重大科研项目进展。',
    tags: ['国家重点研发计划', 'AI', '药物发现', '交叉学科'],
    content: '近日，国家科技部正式公布了2026年度国家重点研发计划立项名单。我校计算机科学与生命科学交叉研究团队申报的"基于人工智能的小分子药物高效筛选与优化关键技术"项目成功获批，获得资助经费3,200万元。\n\n该项目由计算机学院张明远院士和生命科学学院李文华教授联合牵头，汇聚了两院20余位核心研究人员。项目将围绕人工智能辅助药物发现中的核心科学问题，重点攻关分子表征学习、靶点-药物亲和力预测、多目标药物分子生成等关键技术。\n\n张明远院士表示，该项目有望将传统药物筛选周期从2-3年缩短至3-6个月，效率提升50倍以上，为重大疾病的新药研发提供有力支撑。\n\n近年来，我校高度重视学科交叉融合，大力推动"AI+"战略，已在人工智能辅助医疗诊断、智慧农业、智能制造等领域取得了一系列标志性成果。',
    contentImage: null
  },
  {
    id: 2, title: '第十二届校园文化艺术节圆满落幕',
    summary: '历时两周的校园文化艺术节吸引了近万名师生参与，涵盖音乐、戏剧、书法、摄影等多个板块。',
    category: '校园', publishDate: '2026-07-05', image: images.newsFestival,
    author: '王雅婷', authorBio: '校园文化版编辑，热爱记录校园里的每一个精彩瞬间。',
    tags: ['文化艺术节', '校园活动', '音乐', '戏剧'],
    content: '7月4日晚，随着一场精彩的闭幕音乐会在大礼堂上演，我校第十二届校园文化艺术节圆满落下帷幕。本届艺术节历时两周，共举办各类活动50余场，吸引近万名师生参与，创历届之最。\n\n本届艺术节以"青春绽放，艺韵悠长"为主题，设置了音乐、戏剧、书法、摄影、舞蹈五大板块。其中，"校园原创音乐大赛"收到了来自全校各院系的86件参赛作品，最终由计算机学院大三学生林小琳的原创歌曲《这里的风》摘得桂冠。\n\n话剧板块同样精彩纷呈，文学与传播学院话剧社改编的《茶馆》新版获得了满堂喝彩。书法与摄影展览在图书馆一楼大厅持续展出两周，累计观展人数超过3,000人次。\n\n校团委书记表示："校园文化艺术节已成为我校最具影响力的文化品牌活动之一，为广大学子提供了展示才华的舞台，也丰富了校园文化生活。"',
    contentImage: null
  },
  {
    id: 3, title: '2026年秋季学期开学安排公告',
    summary: '2026年秋季学期将于9月1日正式开学，新生报到时间为8月28日至30日，请各位同学做好相关准备。',
    category: '通知', publishDate: '2026-06-28', image: images.newsAutumnCampus,
    author: '教务处', authorBio: '',
    tags: ['开学安排', '新生报到', '学期安排'],
    content: '根据学校教学工作安排，现将2026年秋季学期开学相关事宜通知如下：\n\n一、开学时间\n- 在校老生：2026年9月1日（星期二）正式上课\n- 新生报到：2026年8月28日至30日\n- 新生军训：2026年9月2日至9月15日\n- 研究生新生报到：2026年9月3日至4日\n\n二、报到地点\n- 本科新生：各学院报到点（详见录取通知书）\n- 研究生新生：研究生院一楼大厅\n\n三、注意事项\n1. 请携带录取通知书、身份证、高考准考证等相关材料\n2. 新生需提前在"智慧校园"APP上完成线上注册\n3. 学校在火车站、机场设有迎新接站点\n4. 因故不能按时报到者，须提前向所在学院请假\n\n四、联系方式\n- 招生咨询热线：010-62888888\n- 校园服务热线：010-62888666\n\n请各位同学合理安排行程，按时返校报到。祝新同学大学生活愉快！',
    contentImage: null
  },
  {
    id: 4, title: '我校学生在全国大学生数学建模竞赛中获佳绩',
    summary: '6支队伍获得全国一等奖，12支队伍获得全国二等奖，参赛规模和获奖数量均创历史新高。',
    category: '荣誉', publishDate: '2026-06-20', image: images.newsCompetition,
    author: '陈志远', authorBio: '教务科研版编辑，关注学生竞赛与学术成果。',
    tags: ['数学建模', '全国竞赛', '学生获奖'],
    content: null
  },
  {
    id: 5, title: '牛犇大学-华为联合实验室揭牌成立',
    summary: '双方将在5G/6G通信、边缘计算和智能终端等领域展开深度合作，联合培养高层次技术人才。',
    category: '学术', publishDate: '2026-06-15', image: images.newsLabOpening,
    author: '张晓明', authorBio: '牛犇大学新闻中心高级编辑，负责学术科研类新闻报道。',
    tags: ['校企合作', '华为', '联合实验室', '5G'],
    content: null
  },
  {
    id: 6, title: '校园美食节精彩来袭',
    summary: '来自全国各地50多种特色美食齐聚校园，还有厨艺大赛和美食品鉴等互动环节等你来。',
    category: '校园', publishDate: '2026-06-10', image: images.newsFoodFest,
    author: '王雅婷', authorBio: '',
    tags: ['美食节', '校园生活', '美食文化'],
    content: null
  },
  {
    id: 7, title: '关于暑期校园施工安全的通知',
    summary: '暑期期间部分教学楼将进行维修改造，请注意施工区域的安全提示，合理安排学习和出行。',
    category: '通知', publishDate: '2026-06-05', image: images.newsConstruction,
    author: '后勤管理处', authorBio: '',
    tags: ['校园通知', '暑期施工', '安全提示'],
    content: null
  },
  {
    id: 8, title: '校友企业家返校分享创业经验',
    summary: '20余位成功创业校友重返母校，与在校学子分享创业历程和行业洞察。',
    category: '校园', publishDate: '2026-06-01', image: images.newsAlumni,
    author: '李文博', authorBio: '',
    tags: ['校友', '创业', '分享会'],
    content: null
  },
  {
    id: 9, title: '我校教授入选国家"万人计划"',
    summary: '计算机学院张明远教授、材料学院王建国教授入选国家高层次人才特殊支持计划。',
    category: '荣誉', publishDate: '2026-05-25', image: images.newsAward,
    author: '陈志远', authorBio: '',
    tags: ['万人计划', '张明远', '高层次人才'],
    content: null
  }
])

const currentImage = computed(() => {
  return newsDetail.value?.contentImage || newsDetail.value?.image || null
})

const hasImage = computed(() => {
  return !!(newsDetail.value?.contentImage || newsDetail.value?.image)
})

const contentParagraphs = computed(() => {
  if (!newsDetail.value?.content) return []
  const all = parseContent(newsDetail.value.content)
  // Split at midpoint to insert image
  const mid = Math.floor(all.length * 0.4)
  return all.slice(0, mid)
})

const remainingParagraphs = computed(() => {
  if (!newsDetail.value?.content) return []
  const all = parseContent(newsDetail.value.content)
  const mid = Math.floor(all.length * 0.4)
  return all.slice(mid)
})

const parseContent = (text) => {
  return text.split('\n').filter(line => line.trim()).map(line => {
    if (line.endsWith('：') || line.endsWith(':') || line.length < 20 && !line.startsWith(' ')) {
      return { type: 'text', text: line }
    }
    return { type: 'text', text: line }
  })
}

const currentTags = computed(() => newsDetail.value?.tags || [])

const hotTagList = ['学科建设', '双一流', '人工智能', '招生简章', '校企合作', '校园文化', '科研突破', '创新创业', 'ESI', '社会实践']
const hotTags = ref(hotTagList)

const relatedNews = computed(() => {
  if (!newsDetail.value) return allNewsData.value.slice(1, 5)
  return allNewsData.value
    .filter(n => n.id !== newsDetail.value.id && n.category === newsDetail.value.category)
    .slice(0, 4)
    .concat(
      allNewsData.value.filter(n => n.id !== newsDetail.value.id && n.category !== newsDetail.value.category).slice(0, 2)
    )
    .slice(0, 5)
})

const prevNews = computed(() => {
  if (!newsDetail.value) return null
  const idx = allNewsData.value.findIndex(n => n.id === newsDetail.value.id)
  return idx > 0 ? allNewsData.value[idx - 1] : null
})

const nextNews = computed(() => {
  if (!newsDetail.value) return null
  const idx = allNewsData.value.findIndex(n => n.id === newsDetail.value.id)
  return idx < allNewsData.value.length - 1 ? allNewsData.value[idx + 1] : null
})

const fontSizeLabel = computed(() => {
  const map = { 14: '小', 16: '中', 18: '大' }
  return map[fontSize.value] || '中'
})

const getCategoryClass = (cat) => {
  const map = {
    '通知': 'bg-amber-50 text-amber-600',
    '校园': 'bg-green-50 text-green-600',
    '学术': 'bg-blue-50 text-blue-600',
    '荣誉': 'bg-purple-50 text-purple-600'
  }
  return map[cat] || 'bg-campus-primary-50 text-campus-primary'
}

const handleLike = () => {
  isLiked.value = !isLiked.value
  likeCount.value += isLiked.value ? 1 : -1
}

const handleShare = () => {
  if (navigator.clipboard) {
    navigator.clipboard.writeText(window.location.href)
    alert('链接已复制到剪贴板')
  }
}

const handleBookmark = () => {
  isBookmarked.value = !isBookmarked.value
}

const shareToSocial = (platform) => {
  if (platform === 'link') {
    handleShare()
  } else {
    alert(`即将分享到${platform === 'wechat' ? '微信' : platform === 'weibo' ? '微博' : 'QQ'}`)
  }
}

const handleFontSize = (direction) => {
  if (direction === 'increase' && fontSize.value < 20) {
    fontSize.value += 2
  } else if (direction === 'decrease' && fontSize.value > 12) {
    fontSize.value -= 2
  }
  document.querySelector('.article-content').style.fontSize = fontSize.value + 'px'
}

const loadNewsDetail = async (newsId) => {
  loading.value = true
  try {
    const newsRes = await getNewsById(newsId)
    if (newsRes.data.success && newsRes.data.data) {
      const item = newsRes.data.data
      newsDetail.value = {
        ...item,
        category: { 'NOTICE': '通知', 'ADMIN': '校园', 'ACADEMIC': '学术', 'HONOR': '荣誉' }[item.category] || item.category,
        publishDate: formatDateStr(item.publishDate),
        updatedAt: formatDateStr(item.updatedAt)
      }
      viewCount.value = item.viewCount || Math.floor(Math.random() * 2000) + 500
    } else {
      newsDetail.value = null
    }
  } catch (e) {
    newsDetail.value = null
  }
  loading.value = false
}

const formatDateStr = (date) => {
  if (!date) return ''
  const d = new Date(date)
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')} ${String(d.getHours()).padStart(2, '0')}:${String(d.getMinutes()).padStart(2, '0')}`
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
      { id: 3, label: '招生就业', path: '/admissions', isActive: false, sortOrder: 3 },
      { id: 4, label: '科学研究', path: '/research', isActive: false, sortOrder: 4 },
      { id: 5, label: '校园生活', path: '/campus-life', isActive: false, sortOrder: 5 },
      { id: 6, label: '新闻动态', path: '/news', isActive: true, sortOrder: 6 }
    ]
    schoolInfo.value = { name: '牛犇大学', address: '北京市海淀区学院路100号', phone: '010-62888888' }
  }
  await loadNewsDetail(route.params.id)
})

// Watch route changes for client-side navigation
watch(() => route.params.id, (newId) => {
  if (newId) {
    loading.value = true
    window.scrollTo(0, 0)
    loadNewsDetail(newId)
  }
})
</script>
