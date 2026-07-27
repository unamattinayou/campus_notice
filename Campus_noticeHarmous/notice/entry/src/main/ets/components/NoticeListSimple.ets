import { Notice } from '../http/noticeApi'

@Component
export struct NoticeListSimple {
  @Prop dataList: Notice[] = []
  itemClick: (noticeItem: Notice) => void = () => {}

  build() {
    Column() {
      if (this.dataList.length <= 0) {
        Text("暂无公告")
          .fontSize(13)
          .fontColor("#999999")
          .width("100%")
          .textAlign(TextAlign.Center)
          .margin({ top: 15 })
      } else {
        List({ space: 6 }) {
          ForEach(this.dataList, (item: Notice) => {
            ListItem() {
              Text(item.title)
                .fontSize(17)
                .fontColor("#333333")
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .width("100%")
            }
            .onClick(() => this.itemClick(item))
          })
        }
        .width("100%")
        .layoutWeight(1)
      }
    }
    .width("100%")
    .height("100%")
  }
}