import axios from 'axios'

const api = axios.create({
  baseURL: '/api',
  timeout: 10000
})

export const getHomePageData = () => api.get('/home')
export const getStats = () => api.get('/stats')
export const getAcademicPrograms = () => api.get('/academic-programs')
export const getCampusLifeFeatures = () => api.get('/campus-life')
export const getNews = () => api.get('/news')
export const getNewsById = (id) => api.get(`/news/${id}`)
export const getNavLinks = () => api.get('/nav-links')
export const getFooterLinks = () => api.get('/footer-links')
export const getSchoolInfo = () => api.get('/school-info')