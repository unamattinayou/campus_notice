import { Notice } from '../http/noticeApi';
interface RouterParams {
  noticeData?: Notice;
}
@Component
export struct NoticeDetail {

  @Prop data: Notice = {
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
  onBack: () => void = (): void => {};


  build() {
    Column() {
      // 顶部导航栏（固定不动）
      Row() {
        Text("< 返回")
          .fontSize(16)
          .fontColor('#007DFF')
          .onClick(() => {
            this.onBack();
          })
        Text(this.data.title)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Text("    ")
      }
      .width('100%')
      .margin({ bottom: 20 })

      // 发布信息栏（固定不动）
      Text(`发布时间：${this.data.publishTime}    分类：${this.data.category}    发布人：${this.data.publisherName}`)
        .fontSize(13)
        .fontColor('#666666')
        .margin({ bottom: 20 })

      // ✅ 修复后的正文滚动区域
      // Scroll() {
      //   Column() {
      //     Text(this.data.content)
      //       .fontSize(15)
      //       .fontColor('#333333')
      //       .lineHeight(28)
      //       .width('100%')
      //   }
      //   .width('100%')
      //   .padding({ bottom: 40 }) // 底部预留40vp空白，避免最后一行被遮挡
      // }
      // .scrollable(ScrollDirection.Vertical)
      // .scrollBar(BarState.Auto)
      // .layoutWeight(1)
      // 正文滚动区域（顶格对齐版本）
      Scroll() {
        Column() {
          Text(this.data.content)
            .fontSize(15)
            .fontColor('#333333')
            .lineHeight(28)
            .width('100%')
        }
        .width('100%')
        .padding({ bottom: 40 }) // 只保留底部留白，防止最后一行被遮挡
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Auto)
      .layoutWeight(1)

    }
    .padding(16)
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
function getCategoryText(rawCat:string):string{
  switch(rawCat){
    case "NOTICE": return "通知";
    case "ADMIN": return "行政";
    case "ACADEMIC": return "学术";
    default: return rawCat;
  }
}

