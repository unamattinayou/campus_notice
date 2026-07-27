import http from '@ohos.net.http';

export interface Notice {
  id: number;
  title: string;
  content: string;
  summary: string;
  category: string;
  priority: string;
  status: string;
  publisherId: number;
  publisherName: string;
  publishTime: string;
  isTop: number;
  viewCount: number;
  attachmentUrl: string | null;
  isDeleted: number;
  createTime: string;
  updateTime: string;
}

export interface Result<T> {
  code: number;
  message: string;
  data: T;
}

const BASE_URL = "http://10.104.59.68:8080/api/notice";

// export async function getNoticeById(id: number): Promise<Notice> {
//   const httpClient = http.createHttp()
//   const url = `${BASE_URL}/detail/${id}`
//   const res = await httpClient.request(url, {
//     method: http.RequestMethod.GET
//   })
//   httpClient.destroy()
//   return JSON.parse(res.result as string) as Notice
// }

export async function getNoticeList(): Promise<Notice[]> {
  return new Promise((resolve, reject) => {
    const httpRequest = http.createHttp();
    const url = `${BASE_URL}/published`;
    httpRequest.request(
      url,
      {
        method: http.RequestMethod.GET,
        header: { 'Content-Type': 'application/json' }
      },
      (err: Error | null, res: http.HttpResponse) => {
        httpRequest.destroy();
        if (!err && res.responseCode === 200) {
          const raw = JSON.parse(res.result as string) as Result<Notice[]>;
          if (raw.code === 200 && Array.isArray(raw.data)) {
            resolve(raw.data);
          } else {
            resolve([]);
          }
        } else {
          reject(err);
        }
      }
    );
  });
}

export async function getNoticeById(id: number): Promise<Notice> {
  const httpClient = http.createHttp()
  const resp = await httpClient.request(`${BASE_URL}/detail/${id}`, { method: http.RequestMethod.GET })
  httpClient.destroy()
  // 剥离外层code、message，只返回真实公告data
  return JSON.parse(resp.result as string).data
}


export async function getPublishedNotices(): Promise<Notice[]> {
  return new Promise((resolve, reject) => {
    const httpRequest = http.createHttp();
    const url = `${BASE_URL}/published`;
    httpRequest.request(
      url,
      {
        method: http.RequestMethod.GET,
        header: { 'Content-Type': 'application/json' }
      },
      (err: Error | null, res: http.HttpResponse) => {
        httpRequest.destroy();
        if (!err && res.responseCode === 200) {
          const raw = JSON.parse(res.result as string) as Result<Notice[]>;
          if (raw.code === 200 && Array.isArray(raw.data)) {
            resolve(raw.data);
          } else {
            resolve([]);
          }
        } else {
          reject(err);
        }
      }
    );
  });
}

export async function searchNotices(keyword: string, category: string): Promise<Notice[]> {
  return new Promise((resolve, reject) => {
    const httpRequest = http.createHttp();
    const encodedKeyword = encodeURIComponent(keyword);
    const encodedCategory = encodeURIComponent(category);
    const url = `${BASE_URL}/search?keyword=${encodedKeyword}&category=${encodedCategory}`;
    httpRequest.request(
      url,
      {
        method: http.RequestMethod.GET,
        header: { 'Content-Type': 'application/json' }
      },
      (err: Error | null, res: http.HttpResponse) => {
        httpRequest.destroy();
        if (!err && res.responseCode === 200) {
          const raw = JSON.parse(res.result as string) as Result<Notice[]>;
          if (raw.code === 200 && Array.isArray(raw.data)) {
            resolve(raw.data);
          } else {
            resolve([]);
          }
        } else {
          reject(err);
        }
      }
    );
  });

}