@Component
export struct ChartTab {
  build() {
    Column() {
      Text("公告分布图")
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .padding({ top: 20 })
      Blank()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f8f8f8')
  }
}