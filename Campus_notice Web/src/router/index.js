import { createRouter, createWebHistory } from 'vue-router'
import HomePage from '../pages/HomePage.vue'
import DepartmentsPage from '../pages/DepartmentsPage.vue'
import AdmissionsPage from '../pages/AdmissionsPage.vue'
import ResearchPage from '../pages/ResearchPage.vue'
import CampusLifePage from '../pages/CampusLifePage.vue'
import NewsPage from '../pages/NewsPage.vue'
import NewsDetailPage from '../pages/NewsDetailPage.vue'

const routes = [
  { path: '/', name: 'home', component: HomePage },
  { path: '/departments', name: 'departments', component: DepartmentsPage },
  { path: '/admissions', name: 'admissions', component: AdmissionsPage },
  { path: '/research', name: 'research', component: ResearchPage },
  { path: '/campus-life', name: 'campus-life', component: CampusLifePage },
  { path: '/news', name: 'news', component: NewsPage },
  { path: '/news/:id', name: 'news-detail', component: NewsDetailPage },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
  scrollBehavior() {
    return { top: 0 }
  }
})

export default router
