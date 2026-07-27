import router from '@ohos.router';
import { getNewsDetail, NewsItem } from '../http/portalApi';

@Entry
@Component
struct NewsDetailPage {
  @State detailData: NewsItem | null = null;
  @State isLoading: boolean = true;
  @State loadError: string = "";
  @State isLiked: boolean = false;
  @State isBookmarked: boolean = false;
  @State likeCount: number = 42;
  @State fontSize: number = 16;

  async aboutToAppear(): Promise<void> {
    const params = router.getParams() as Record<string, Object>;
    if (params && params.newsData) {
      this.detailData = params.newsData as NewsItem;
      this.isLoading = false;
    } else if (params && params.id) {
      await this.loadDetail(Number(params.id));
    } else {
      this.isLoading = false;
      this.loadError = "缺少新闻 ID";
    }
  }

  async loadDetail(id: number): Promise<void> {
    try {
      this.isLoading = true;
      this.loadError = "";
      const item = await getNewsDetail(id);
      this.detailData = {
        id: item.id,
        title: item.title,
        summary: item.summary,
        content: item.content,
        category: this.getCategoryLabel(item.category),
        publishDate: this.formatDate(item.publishDate),
        author: item.author,
        authorBio: item.authorBio,
        tags: item.tags,
        viewCount: item.viewCount,
        isTop: item.isTop,
        status: item.status
      };
    } catch (error) {
      this.loadError = "加载失败：" + JSON.stringify(error);
      console.error(this.loadError);
      this.loadMockDetail(id);
    } finally {
      this.isLoading = false;
    }
  }

  loadMockDetail(id: number): void {
    this.detailData = {
      id: id,
      title: '我校科研团队获国家重点研发计划立项',
      summary: '计算机科学与生命科学交叉研究团队成功获批国家重点研发计划项目，将在人工智能辅助药物发现领域展开深入探索。',
      content: '近日，国家科技部正式公布了2026年度国家重点研发计划立项名单。我校计算机科学与生命科学交叉研究团队申报的"基于人工智能的小分子药物高效筛选与优化关键技术"项目成功获批，获得资助经费3,200万元。\n\n该项目由计算机学院张明远院士和生命科学学院李文华教授联合牵头，汇聚了两院20余位核心研究人员。项目将围绕人工智能辅助药物发现中的核心科学问题，重点攻关分子表征学习、靶点-药物亲和力预测、多目标药物分子生成等关键技术。\n\n张明远院士表示，该项目有望将传统药物筛选周期从2-3年缩短至3-6个月，效率提升50倍以上，为重大疾病的新药研发提供有力支撑。\n\n近年来，我校高度重视学科交叉融合，大力推动"AI+"战略，已在人工智能辅助医疗诊断、智慧农业、智能制造等领域取得了一系列标志性成果。',
      category: '学术',
      publishDate: '2026-07-10',
      author: '李文博',
      authorBio: '科研新闻编辑，专注报道学校重大科研项目进展。',
      tags: ['国家重点研发计划', 'AI', '药物发现', '交叉学科'],
      viewCount: 1286
    };
  }

  getCategoryLabel(cat: string): string {
    const map: Record<string, string> = {
      'NOTICE': '通知',
      'ADMIN': '校园',
      'ACADEMIC': '学术',
      'HONOR': '荣誉'
    };
    return map[cat] || cat;
  }

  formatDate(date: string): string {
    if (!date) return '';
    return date.substring(0, 10);
  }

  getCategoryColor(cat: string): string {
    const map: Record<string, string> = {
      '通知': '#D97706',
      '校园': '#16A34A',
      '学术': '#2563EB',
      '荣誉': '#9333EA'
    };
    return map[cat] || '#0F766E';
  }

  getContentParagraphs(): string[] {
    if (!this.detailData || !this.detailData.content) return [];
    return this.detailData.content.split('\n').filter((line: string) => line.trim().length > 0);
  }

  handleLike(): void {
    this.isLiked = !this.isLiked;
    this.likeCount += this.isLiked ? 1 : -1;
  }

  handleBookmark(): void {
    this.isBookmarked = !this.isBookmarked;
  }

  handleFontSize(increase: boolean): void {
    if (increase && this.fontSize < 20) {
      this.fontSize += 2;
    } else if (!increase && this.fontSize > 12) {
      this.fontSize -= 2;
    }
  }

  goBack(): void {
    router.back();
  }

  build() {
    Column() {
      // Header
      Row() {
        Text('< 返回')
          .fontSize(14)
          .fontColor('#0F766E')
          .onClick(() => { this.goBack(); })
        Text('新闻详情')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E293B')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Text('    ')
          .fontSize(14)
      }
      .width('100%')
      .padding({ left: 12, right: 12, top: 12, bottom: 12 })
      .backgroundColor('#FFFFFF')
      .border({ width: { bottom: 0.5 }, color: { bottom: '#E2E8F0' } })

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
      } else if (this.detailData) {
        Scroll() {
          Column() {
            // Title Section
            Column() {
              Row({ space: 6 }) {
                Text(this.detailData.category)
                  .fontSize(10)
                  .fontColor('#FFFFFF')
                  .backgroundColor(this.getCategoryColor(this.detailData.category))
                  .borderRadius(4)
                  .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                if (this.detailData.isTop) {
                  Text('置顶')
                    .fontSize(10)
                    .fontColor('#FFFFFF')
                    .backgroundColor('#DC2626')
                    .borderRadius(4)
                    .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                }
              }
              .margin({ bottom: 8 })

              Text(this.detailData.title)
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#1E293B')
                .textAlign(TextAlign.Center)
                .width('100%')
                .margin({ bottom: 10 })

              Row({ space: 12 }) {
                if (this.detailData.author) {
                  Text(`作者：${this.detailData.author}`)
                    .fontSize(11)
                    .fontColor('#94A3B8')
                }
                Text(`发布：${this.detailData.publishDate}`)
                  .fontSize(11)
                  .fontColor('#94A3B8')
                if (this.detailData.viewCount) {
                  Text(`浏览：${this.detailData.viewCount}`)
                    .fontSize(11)
                    .fontColor('#94A3B8')
                }
              }
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .margin({ left: 12, right: 12, top: 12, bottom: 8 })

            // Summary
            if (this.detailData.summary) {
              Row() {
                Column()
                  .width(3)
                  .height('100%')
                  .backgroundColor('#0F766E')
                  .margin({ right: 10 })
                Text(this.detailData.summary)
                  .fontSize(12)
                  .fontColor('#475569')
                  .fontStyle(FontStyle.Italic)
                  .layoutWeight(1)
              }
              .width('100%')
              .padding(12)
              .backgroundColor('#F0FDFA')
              .borderRadius(12)
              .margin({ left: 12, right: 12, bottom: 8 })
            }

            // Content
            Column() {
              ForEach(this.getContentParagraphs(), (paragraph: string, index: number) => {
                Text(paragraph)
                  .fontSize(this.fontSize)
                  .fontColor('#334155')
                  .lineHeight(26)
                  .width('100%')
                  .margin({ bottom: 10 })
              }, (paragraph: string, index: number) => index.toString())
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .margin({ left: 12, right: 12, bottom: 8 })

            // Tags
            if (this.detailData.tags && this.detailData.tags.length > 0) {
              Column() {
                Text('标签')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#64748B')
                  .margin({ bottom: 6 })

                Flex({ wrap: FlexWrap.Wrap }) {
                  ForEach(this.detailData.tags, (tag: string) => {
                    Text(`#${tag}`)
                      .fontSize(10)
                      .fontColor('#0F766E')
                      .backgroundColor('#F0FDFA')
                      .borderRadius(10)
                      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                      .margin({ right: 6, bottom: 6 })
                  }, (tag: string) => tag)
                }
              }
              .width('100%')
              .padding(12)
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
              .margin({ left: 12, right: 12, bottom: 8 })
              .alignItems(HorizontalAlign.Start)
            }

            // Actions
            Row() {
              Button(this.isLiked ? `♥ ${this.likeCount}` : `♡ ${this.likeCount}`)
                .fontSize(11)
                .backgroundColor(this.isLiked ? '#FEE2E2' : '#F1F5F9')
                .fontColor(this.isLiked ? '#DC2626' : '#64748B')
                .borderRadius(20)
                .height(32)
                .margin({ right: 8 })
                .onClick(() => { this.handleLike(); })

              Button(this.isBookmarked ? '★ 已收藏' : '☆ 收藏')
                .fontSize(11)
                .backgroundColor(this.isBookmarked ? '#FEF3C7' : '#F1F5F9')
                .fontColor(this.isBookmarked ? '#D97706' : '#64748B')
                .borderRadius(20)
                .height(32)
                .margin({ right: 8 })
                .onClick(() => { this.handleBookmark(); })

              Blank()

              Button('A-')
                .fontSize(11)
                .backgroundColor('#F1F5F9')
                .fontColor('#64748B')
                .borderRadius(16)
                .width(32)
                .height(32)
                .margin({ right: 4 })
                .onClick(() => { this.handleFontSize(false); })

              Button('A+')
                .fontSize(13)
                .backgroundColor('#F1F5F9')
                .fontColor('#64748B')
                .borderRadius(16)
                .width(32)
                .height(32)
                .onClick(() => { this.handleFontSize(true); })
            }
            .width('100%')
            .padding({ left: 12, right: 12, bottom: 12 })
          }
          .padding({ bottom: 20 })
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Auto)
        .layoutWeight(1)
        .backgroundColor('#F8FAFC')
      } else {
        Column() {
          Text('新闻不存在')
            .fontSize(16)
            .fontColor('#64748B')
            .margin({ bottom: 12 })
          Button('返回新闻列表')
            .fontSize(13)
            .backgroundColor('#0F766E')
            .fontColor('#FFFFFF')
            .borderRadius(20)
            .height(36)
            .onClick(() => { this.goBack(); })
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}
