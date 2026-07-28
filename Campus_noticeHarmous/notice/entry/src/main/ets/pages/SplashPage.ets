import router from '@ohos.router';

@Entry
@Component
struct SplashPage {
  @State iconOpacity: number = 0
  @State iconScale: number = 0.6
  @State textOpacity: number = 0
  @State textOffsetY: number = 30
  @State pageOpacity: number = 1

  private timerId: number = -1

  aboutToAppear(): void {
    // 图标淡入 + 缩放动画
    this.iconOpacity = 1
    this.iconScale = 1

    // 文字延迟淡入
    setTimeout(() => {
      this.textOpacity = 1
      this.textOffsetY = 0
    }, 400)

    // 2.5 秒后淡出并跳转到主页面
    this.timerId = setTimeout(() => {
      this.pageOpacity = 0
      setTimeout(() => {
        router.replaceUrl({ url: 'pages/main' })
      }, 400)
    }, 2500)
  }

  aboutToDisappear(): void {
    if (this.timerId !== -1) {
      clearTimeout(this.timerId)
    }
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFFFF')

      Column({ space: 24 }) {
        // 应用图标
        Image($r('app.media.foreground'))
          .width(120)
          .height(120)
          .objectFit(ImageFit.Contain)
          .opacity(this.iconOpacity)
          .scale({ x: this.iconScale, y: this.iconScale })
          .animation({
            duration: 600,
            curve: Curve.EaseOut,
            delay: 100
          })

        // 标语文字
        Column({ space: 8 }) {
          Text('加入牛犇大学')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0F766E')
            .opacity(this.textOpacity)
            .translate({ y: this.textOffsetY })
            .animation({
              duration: 500,
              curve: Curve.EaseOut,
              delay: 400
            })

          Text('让你更加牛犇')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#64748B')
            .opacity(this.textOpacity)
            .translate({ y: this.textOffsetY })
            .animation({
              duration: 500,
              curve: Curve.EaseOut,
              delay: 550
            })
        }
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .opacity(this.pageOpacity)
    .animation({
      duration: 400,
      curve: Curve.EaseInOut
    })
  }
}
