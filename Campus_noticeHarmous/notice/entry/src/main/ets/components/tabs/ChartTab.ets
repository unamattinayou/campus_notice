import { getPublishedNotices, Notice } from '../../http/noticeApi';
import { getCategoryLabel } from '../CategoryMap';

export interface PieDataItem {
  value: number;
  name: string;
  color: string;
}

@Component
export struct ChartTab {
  @State internalData: PieDataItem[] = [];
  @State isLoading: boolean = true;
  @State errorMsg: string = '';

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  private isCanvasReady: boolean = false;

  aboutToAppear() {
    this.loadChartData();
  }

  async loadChartData() {
    try {
      this.isLoading = true;
      this.errorMsg = '';
      const list: Notice[] = await getPublishedNotices();

      if (list.length > 0) {
        console.info('ChartTab 数据样例:', JSON.stringify(list[0]));
      }

      const pieData = this.convertToPieData(list);
      this.internalData = pieData;

      if (this.internalData.length === 0) {
        this.errorMsg = '转换后无有效分类数据';
      }
    } catch (error) {
      console.error('ChartTab 加载失败:', error);
      this.errorMsg = '加载失败: ' + JSON.stringify(error);
      this.internalData = [];
    } finally {
      this.isLoading = false;
      if (this.isCanvasReady && this.internalData.length > 0) {
        this.drawPieChart();
      }
    }
  }

  convertToPieData(list: Notice[]): PieDataItem[] {
    if (!list || list.length === 0) {
      return [];
    }

    const categoryCount: Record<string, number> = {};
    list.forEach(item => {
      const cat = item.category || 'UNKNOWN';
      categoryCount[cat] = (categoryCount[cat] || 0) + 1;
    });

    const colorMap: Record<string, string> = {
      'NOTICE': '#D97706',
      'ADMIN': '#0F766E',
      'ACADEMIC': '#2563EB',
      'UNKNOWN': '#94A3B8'
    };

    const result = Object.keys(categoryCount).map(cat => ({
      value: categoryCount[cat],
      name: getCategoryLabel(cat) || cat,
      color: colorMap[cat] || '#94A3B8'
    }) as PieDataItem);

    return result;
  }

  build() {
    Column() {
      // 顶部 Banner
      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({ angle: 180, colors: [['#134E4A', 0.0], ['#0F766E', 1.0]] })
        Column() {
          Text('公告分布')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
          Text('可视化展示各类公告占比')
            .fontSize(12)
            .fontColor('#E6FFFA')
            .margin({ top: 6 })
        }
      }
      .width('100%')
      .height(110)
      .clip(true)

      // 内容区
      Column() {
        if (this.isLoading) {
          Column() {
            LoadingProgress().width(40).height(40).color('#0F766E')
            Text('加载中...')
              .fontSize(12)
              .fontColor('#64748B')
              .margin({ top: 8 })
          }
          .width('100%')
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        } else if (this.errorMsg) {
          Column() {
            Text('⚠️ ' + this.errorMsg)
              .fontSize(14)
              .fontColor('#DC2626')
              .margin({ bottom: 10 })
            Text('请查看控制台日志')
              .fontSize(12)
              .fontColor('#94A3B8')
          }
          .width('100%')
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        } else if (this.internalData.length === 0) {
          Column() {
            Text('📊')
              .fontSize(48)
              .margin({ bottom: 12 })
            Text('暂无数据')
              .fontSize(14)
              .fontColor('#94A3B8')
          }
          .width('100%')
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        } else {
          // 饼图区域
          Canvas(this.context)
            .width('100%')
            .height(300)
            .margin({ top: 10 })
            .onReady(() => {
              this.isCanvasReady = true;
              this.drawPieChart();
            })

          // 图例区域
          Column({ space: 8 }) {
            ForEach(this.internalData, (item: PieDataItem) => {
              Row({ space: 8 }) {
                Column()
                  .width(12)
                  .height(12)
                  .borderRadius(2)
                  .backgroundColor(item.color)

                Text(item.name)
                  .fontSize(13)
                  .fontColor('#475569')
                  .layoutWeight(1)

                Text(`${item.value}条`)
                  .fontSize(13)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1E293B')
              }
              .width('100%')
              .padding({ left: 12, right: 12 })
            }, (item: PieDataItem) => item.name)
          }
          .width('100%')
          .margin({ top: 10 })
        }
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#F8FAFC')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }

  drawPieChart(): void {
    const ctx = this.context;
    if (!ctx || !ctx.width || ctx.width === 0 || this.internalData.length === 0) {
      return;
    }

    ctx.clearRect(0, 0, ctx.width, ctx.height);

    const width = ctx.width;
    const height = ctx.height;
    const centerX = width / 2;
    const centerY = height / 2;
    const radius = Math.min(width, height) / 2 - 30;
    const innerTextRadius = radius * 0.65;
    const total = this.internalData.reduce((sum, item) => sum + item.value, 0);
    if (total <= 0) return;

    let startAngle = -Math.PI / 2;

    const getContrastTextColor = (hexColor: string): string => {
      const hex = hexColor.replace('#', '');
      const r = parseInt(hex.substring(0, 2), 16);
      const g = parseInt(hex.substring(2, 4), 16);
      const b = parseInt(hex.substring(4, 6), 16);
      const brightness = (r * 299 + g * 587 + b * 114) / 1000;
      return brightness > 160 ? '#222222' : '#ffffff';
    };

    this.internalData.forEach((item) => {
      const sliceAngle = (item.value / total) * 2 * Math.PI;
      ctx.beginPath();
      ctx.moveTo(centerX, centerY);
      ctx.arc(centerX, centerY, radius, startAngle, startAngle + sliceAngle);
      ctx.closePath();
      ctx.fillStyle = item.color;
      ctx.fill();

      const midAngle = startAngle + sliceAngle / 2;
      const textX = centerX + Math.cos(midAngle) * innerTextRadius;
      const textY = centerY + Math.sin(midAngle) * innerTextRadius;

      const percent = ((item.value / total) * 100).toFixed(1);
      const textLine1 = item.name;
      const textLine2 = `${item.value}条 | ${percent}%`;
      const textColor = getContrastTextColor(item.color);

      ctx.font = "bold 32px system-ui";
      ctx.textAlign = "center";
      ctx.textBaseline = "middle";
      ctx.fillStyle = textColor;
      ctx.strokeStyle = textColor === '#fff' ? 'rgba(0,0,0,0.2)' : 'rgba(255,255,255,0.2)';
      ctx.lineWidth = 1;

      ctx.strokeText(textLine1, textX, textY - 10);
      ctx.fillText(textLine1, textX, textY - 10);

      ctx.font = "24px system-ui";
      ctx.strokeText(textLine2, textX, textY + 10);
      ctx.fillText(textLine2, textX, textY + 10);

      startAngle += sliceAngle;
    });
  }
}
