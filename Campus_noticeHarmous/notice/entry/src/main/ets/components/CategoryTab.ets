@Component
export struct CategoryTab {
  @Prop categoryList: string[] = [];
  @Prop originCategory: string = "";
  onCategoryChange: (value: string) => void = (v: string): void => {};
  @State localCategory: string = "";

  aboutToAppear(): void {
    this.localCategory = this.originCategory;
  }

  build() {
    Scroll() {
      Row({ space: 8 }) {
        ForEach(this.categoryList, (item: string) => {
          Text(item)
            .fontSize(13)
            .padding({ left: 16, right: 16, top: 6, bottom: 6 })
            .borderRadius(20)
            .backgroundColor(this.localCategory === item ? '#0F766E' : '#FFFFFF')
            .fontColor(this.localCategory === item ? '#FFFFFF' : '#64748B')
            .border({ width: this.localCategory === item ? 0 : 1, color: '#E2E8F0' })
            .onClick(() => {
              this.localCategory = item;
              this.onCategoryChange(item);
            })
        })
      }
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
    .margin({ bottom: 12 })
  }
}
