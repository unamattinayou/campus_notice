import router from '@ohos.router';
// import { Notice } from '../http/noticeApi';
import { Notice, getNoticeById } from '../http/noticeApi';
// 分类英文转中文
function getCategoryText(rawCat: string): string {
  switch (rawCat) {
    case "NOTICE": return "通知";
    case "ADMIN": return "行政";
    case "ACADEMIC": return "学术";
    default: return rawCat;
  }
}

@Entry
@Component
struct NoticeDetailPage {
  @State detailData: Notice = {
    id: 0,
    title: "",
    content: "",
    summary: "",
    category: "",
    priority: "",
    status: "",
    publisherId: 0,
    publisherName: "",
    publishTime: "",
    isTop: 0,
    viewCount: 0,
    attachmentUrl: null,
    isDeleted: 0,
    createTime: "",
    updateTime: ""
  };

  // aboutToAppear(): void {
  //   // 接收主页面传过来的公告数据
  //   const params = router.getParams() as Record<string, Object>;
  //   if (params && params['noticeData']) {
  //     this.detailData = params['noticeData'] as Notice;
  //   }
  // }
  async aboutToAppear(): Promise<void> {
    const params = router.getParams() as Record<string, Object>;
    // 有完整对象直接用
    if (params?.noticeData) {
      this.detailData = params.noticeData as Notice
    }
    // 只有id → 调用函数查数据赋值
    else if (params?.id) {
      this.detailData = await getNoticeById(Number(params.id))
    }
  }


  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Text("< 返回")
          .fontSize(16)
          .fontColor('#007DFF')
          .onClick(() => {
            router.back(); // 系统返回上一页
          })
        Text(this.detailData.title)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Text("    ")
      }
      .width('100%')
      .margin({ bottom: 20 })

      // 发布信息栏
      Text(`发布时间：${this.detailData.publishTime}    分类：${getCategoryText(this.detailData.category)}    发布人：${this.detailData.publisherName}`)
        .fontSize(13)
        .fontColor('#666666')
        .margin({ bottom: 20 })

      // 正文滚动区域
      // Scroll() {
      //   Column() {
      //     Text(this.detailData.content)
      //       .fontSize(15)
      //       .fontColor('#333333')
      //       .lineHeight(28)
      //       .width('100%')
      //   }
      //   .width('100%')
      //   .padding({ bottom: 40 })
      // }
      // .scrollable(ScrollDirection.Vertical)
      // .scrollBar(BarState.Auto)
      // .layoutWeight(1)

      // 正文滚动区域（顶格对齐版本）
      Scroll() {
        Column() {
          Text(this.detailData.content)
            .fontSize(15)
            .fontColor('#333333')
            .lineHeight(28)
            .width('100%')
        }
        .width('100%')
        .padding({ bottom: 50 }) // 只保留底部留白，防止最后一行被遮挡
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Auto)
      // .layoutWeight(1)
    }
    .padding(16)
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}