import router from '@ohos.router';
import { Notice,getNoticeList } from '../../http/noticeApi';
import { NoticeDetail } from '../NoticeDetail';
import { NoticeListSimple } from '../NoticeListSimple';

// 轮播只保存【图片资源 + 公告id】
interface BannerItem {
  imgResource: Resource;
  noticeId: number;
}

@Component
export struct HomeTab {
  @State allNoticeData: Notice[] = []

  // 接口加载公告数据
  async loadNotice(): Promise<void> {
    try {
      const resList = await getNoticeList()
      this.allNoticeData = resList
      console.info("接口加载全部公告成功", JSON.stringify(this.allNoticeData))
    } catch (err) {
      console.error("请求公告接口失败", JSON.stringify(err))
      this.allNoticeData = []
    }
  }

  filterComputer(): Notice[] {
    console.info("原始allNoticeData长度：", this.allNoticeData.length, JSON.stringify(this.allNoticeData))
    const list = this.allNoticeData.filter(item => item.title.includes("计算机"))
    console.info("计算机筛选结果", JSON.stringify(list))
    return list
  }

  filterManage(): Notice[] {
    return this.allNoticeData.filter(item => item.title.includes("管理"))
  }

  filterMarx(): Notice[] {
    return this.allNoticeData.filter(item => item.title.includes("马克思") || item.title.includes("马院"))
  }

  filterForeign(): Notice[] {
    return this.allNoticeData.filter(item => item.title.includes("外国语") || item.title.includes("外语"))
  }

  // 公告条目点击跳转详情
  clickNotice(item: Notice): void {
    router.pushUrl({ url: "pages/NoticeDetailPage", params: { id: item.id } })
  }

  @State bannerList: BannerItem[] = [
    { imgResource: $r('app.media.sidi'), noticeId: 1 },
    { imgResource: $r('app.media.sishui'), noticeId: 2 },
    { imgResource: $r('app.media.qingshui'), noticeId: 3 }
  ];

  // 轮播图点击跳转
  goBannerDetail(item: BannerItem): void {
    router.pushUrl({
      url: 'pages/NoticeDetailPage',
      params: { id: item.noticeId }
    })
  }

  // 页面进入触发加载接口
  aboutToAppear() {
    this.loadNotice()
  }

  build() {
    Column() {
      Text("校园公告查询系统")
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .width("100%")
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })

      Swiper() {
        ForEach(this.bannerList, (item: BannerItem) => {
          Image(item.imgResource)
            .width("100%")
            .height(160)
            .objectFit(ImageFit.Cover)
            .borderRadius(12)
            .onClick(() => {
              this.goBannerDetail(item);
            })
        })
      }
      .autoPlay(true)
      .interval(3000)
      .loop(true)
      .width("100%")
      .padding({ left: 16, right: 16 })
      .margin({ bottom:12 })

      Scroll() {
        Column({ space: 16 }) {
          // 计算机学院卡片
          Column() {
            Text("计算机学院")
              .fontSize(17)
              .fontWeight(FontWeight.Medium)
              .width("100%")
              .margin({ bottom: 8 })
            NoticeListSimple({
              dataList: this.filterComputer(),
              itemClick: (item) => this.clickNotice(item)
            })
          }
          .width("92%")
          .height(160)
          .padding(14)
          .backgroundColor(Color.White)
          .borderRadius(10)
          .margin({ left: "4%", right: "4%" })

          // 管理学院卡片
          Column() {
            Text("管理学院")
              .fontSize(17)
              .fontWeight(FontWeight.Medium)
              .width("100%")
              .margin({ bottom: 8 })
            NoticeListSimple({
              dataList: this.filterManage(),
              itemClick: (item) => this.clickNotice(item)
            })
          }
          .width("92%")
          .height(160)
          .padding(14)
          .backgroundColor(Color.White)
          .borderRadius(10)
          .margin({ left: "4%", right: "4%" })

          // 马克思主义学院卡片
          Column() {
            Text("马克思主义学院")
              .fontSize(17)
              .fontWeight(FontWeight.Medium)
              .width("100%")
              .margin({ bottom: 8 })
            NoticeListSimple({
              dataList: this.filterMarx(),
              itemClick: (item) => this.clickNotice(item)
            })
          }
          .width("92%")
          .height(160)
          .padding(14)
          .backgroundColor(Color.White)
          .borderRadius(10)
          .margin({ left: "4%", right: "4%" })

          // 外国语学院卡片
          Column() {
            Text("外国语学院")
              .fontSize(17)
              .fontWeight(FontWeight.Medium)
              .width("100%")
              .margin({ bottom: 8 })
            NoticeListSimple({
              dataList: this.filterForeign(),
              itemClick: (item) => this.clickNotice(item)
            })
          }
          .width("92%")
          .height(160)
          .padding(14)
          .backgroundColor(Color.White)
          .borderRadius(10)
          .margin({ left: "4%", right: "4%" })
        }
        .margin({ top: 10, bottom: 20 })
      }
      .width("100%")
      .layoutWeight(1)

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f8f8f8')
  }
}