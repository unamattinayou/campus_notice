
// notice模块路由
export const cafucRoutes = [

  {
    path: '/notice',
    component: () => import('@/layout/index'),
    alwaysShow: true,
    meta: { title: '公告管理', icon: 'shopping' },
    children: [
      {
        path: 'add',
        component: () => import('@/views/notice/Edit.vue'),
        name: 'NoticeAdd',
        meta: { title: '新增公告', icon: 'edit' }
      },
      {
        path: 'detail/:id',
        component: () => import('@/views/notice/Detail.vue'),
        name: 'NoticeDetail',
        meta: { title: '公告详情', icon: 'documentation' }
      },
      {
        path: 'edit/:id',
        component: () => import('@/views/notice/Edit.vue'),
        name: 'NoticeEdit',
        meta: { title: '编辑公告', icon: 'edit' }
      },
      {
        path: 'review',
        component: () => import('@/views/notice/Review.vue'),
        name: 'NoticeReview',
        meta: { title: '公告审核', icon: 'check', roles: ['admin'] }
      }
    ]
  }
]
