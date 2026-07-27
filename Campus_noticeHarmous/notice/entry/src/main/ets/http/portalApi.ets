import http from '@ohos.net.http';

// 门户后端响应包装（来自 Campus_notice Web Backed）
export interface ApiResponse<T> {
  success: boolean;
  data: T;
}

export interface NavLink {
  id: number;
  label: string;
  path: string;
  isActive: boolean;
  sortOrder: number;
}

export interface Stat {
  id: number;
  statKey: string;
  statValue: string;
  statLabel: string;
}

export interface AcademicProgram {
  id: number;
  code: string;
  name: string;
  description: string;
}

export interface CampusLifeFeature {
  id: number;
  title: string;
  description: string;
}

export interface NewsItem {
  id: number;
  title: string;
  summary: string;
  content?: string;
  category: string;
  publishDate: string;
  author?: string;
  authorBio?: string;
  tags?: string[];
  viewCount?: number;
  image?: string;
  isTop?: boolean;
  status?: string;
}

export interface FooterLink {
  id: number;
  section: string;
  label: string;
  path: string;
  sortOrder: number;
}

export interface SchoolInfo {
  id: number;
  name: string;
  address: string;
  postalCode?: string;
  phone: string;
}

export interface HomePageData {
  navLinks?: NavLink[];
  stats?: Stat[];
  academicPrograms?: AcademicProgram[];
  campusLifeFeatures?: CampusLifeFeature[];
  news?: NewsItem[];
  footerLinks?: Record<string, FooterLink[]>;
  schoolInfo?: SchoolInfo;
}

// 门户后端基础地址（与公告后端分开部署，端口 8081）
const BASE_URL = "http://10.104.59.68:8081/api";

// 通用 GET 请求封装
function getRequest<T>(path: string): Promise<T> {
  return new Promise((resolve, reject) => {
    const httpRequest = http.createHttp();
    const url = `${BASE_URL}${path}`;
    httpRequest.request(
      url,
      {
        method: http.RequestMethod.GET,
        header: { 'Content-Type': 'application/json' }
      },
      (err: Error | null, res: http.HttpResponse) => {
        httpRequest.destroy();
        if (!err && res.responseCode === 200) {
          try {
            const raw = JSON.parse(res.result as string) as ApiResponse<T>;
            if (raw.success && raw.data) {
              resolve(raw.data);
            } else {
              reject(new Error('API returned unsuccessful response'));
            }
          } catch (e) {
            reject(e);
          }
        } else {
          reject(err);
        }
      }
    );
  });
}

export async function getHomePageData(): Promise<HomePageData> {
  return getRequest<HomePageData>('/home');
}

export async function getStats(): Promise<Stat[]> {
  return getRequest<Stat[]>('/stats');
}

export async function getAcademicPrograms(): Promise<AcademicProgram[]> {
  return getRequest<AcademicProgram[]>('/academic-programs');
}

export async function getCampusLifeFeaturesApi(): Promise<CampusLifeFeature[]> {
  return getRequest<CampusLifeFeature[]>('/campus-life');
}

export async function getNewsList(): Promise<NewsItem[]> {
  return getRequest<NewsItem[]>('/news');
}

export async function getNewsDetail(id: number): Promise<NewsItem> {
  return getRequest<NewsItem>(`/news/${id}`);
}

export async function getNavLinks(): Promise<NavLink[]> {
  return getRequest<NavLink[]>('/nav-links');
}

export async function getFooterLinks(): Promise<Record<string, FooterLink[]>> {
  return getRequest<Record<string, FooterLink[]>>('/footer-links');
}

export async function getSchoolInfo(): Promise<SchoolInfo> {
  return getRequest<SchoolInfo>('/school-info');
}
