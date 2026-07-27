import { Notice } from '../http/noticeApi';

@Component
export struct NoticeList {
  @Prop list: Notice[] = [];
  onItemClick: (item: Notice) => void = (item: Notice): void => {};

  getCategoryColor(cat: string): string {
    switch (cat) {
      case 'NOTICE': return '#D97706';
      case 'ADMIN': return '#0F766E';
      case 'ACADEMIC': return '#2563EB';
      default: return '#64748B';
    }
  }

  getCategoryBgColor(cat: string): string {
    switch (cat) {
      case 'NOTICE': return '#FEF3C7';
      case 'ADMIN': return '#F0FDFA';
      case 'ACADEMIC': return '#EFF6FF';
      default: return '#F1F5F9';
    }
  }

  getCategoryText(rawCat: string): string {
    switch (rawCat) {
      case 'NOTICE': return '通知';
      case 'ADMIN': return '行政';
      case 'ACADEMIC': return '学术';
      default: return rawCat;
    }
  }

  formatDate(publishTime: string): string {
    if (!publishTime) return '';
    return publishTime.substring(0, 10);
  }

  build() {
    if (this.list.length === 0) {
      Column() {
        Text('📭')
          .fontSize(48)
          .margin({ bottom: 12 })
        Text('暂无公告数据')
          .fontSize(14)
          .fontColor('#94A3B8')
      }
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    } else {
      List() {
        ForEach(this.list, (item: Notice) => {
          ListItem() {
            Column({ space: 8 }) {
              // 标题行：分类标签 + 置顶标识 + 发布时间
              Row({ space: 8 }) {
                Row({ space: 6 }) {
                  // 分类标签
                  Text(this.getCategoryText(item.category))
                    .fontSize(11)
                    .fontColor(this.getCategoryColor(item.category))
                    .backgroundColor(this.getCategoryBgColor(item.category))
                    .padding({ left: 8, right: 8, top: 3, bottom: 3 })
                    .borderRadius(6)

                  // 置顶标识
                  if (item.isTop === 1) {
                    Text('置顶')
                      .fontSize(10)
                      .fontColor('#FFFFFF')
                      .backgroundColor('#DC2626')
                      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                      .borderRadius(4)
                  }
                }

                Blank()

                Text(this.formatDate(item.publishTime))
                  .fontSize(11)
                  .fontColor('#94A3B8')
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)

              // 标题
              Text(item.title)
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1E293B')
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .width('100%')

              // 摘要（如果有）
              if (item.summary && item.summary.length > 0) {
                Text(item.summary)
                  .fontSize(12)
                  .fontColor('#64748B')
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .width('100%')
              }

              // 底部信息：发布人 + 浏览量
              Row({ space: 4 }) {
                Text('👤')
                  .fontSize(10)
                Text(item.publisherName || '管理员')
                  .fontSize(11)
                  .fontColor('#94A3B8')

                Text(' | ')
                  .fontSize(11)
                  .fontColor('#CBD5E1')

                Text('👁')
                  .fontSize(10)
                Text(`${item.viewCount || 0}`)
                  .fontSize(11)
                  .fontColor('#94A3B8')
              }
              .width('100%')
              .margin({ top: 4 })
            }
            .width('100%')
            .padding(14)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .margin({ bottom: 10 })
          }
          .onClick(() => {
            this.onItemClick(item);
          })
        })
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: 12, right: 12 })
    }
  }
}
