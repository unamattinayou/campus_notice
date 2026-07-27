@Component
export struct SearchBar {
  @Prop originSearchKey: string = "";
  onSearchChange: (value: string) => void = (v: string): void => {};
  @State localSearchKey: string = "";

  aboutToAppear(): void {
    this.localSearchKey = this.originSearchKey;
  }

  build() {
    Row() {
      Text('🔍')
        .fontSize(14)
        .margin({ left: 12, right: 6 })

      TextInput({ placeholder: '请输入关键词搜索公告', text: this.localSearchKey })
        .placeholderColor('#94A3B8')
        .fontSize(14)
        .fontColor('#1E293B')
        .height(40)
        .backgroundColor(Color.Transparent)
        .layoutWeight(1)
        .onChange((value: string) => {
          this.localSearchKey = value;
          this.onSearchChange(value);
        })

      if (this.localSearchKey.length > 0) {
        Text('✕')
          .fontSize(12)
          .fontColor('#94A3B8')
          .margin({ right: 10 })
          .onClick(() => {
            this.localSearchKey = '';
            this.onSearchChange('');
          })
      }
    }
    .width('100%')
    .height(44)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .border({ width: 1, color: '#E2E8F0' })
    .margin({ bottom: 12 })
  }
}
