import router from '@ohos.router';
import { getNewsList, NewsItem } from '../../http/portalApi';

@Component
export struct NewsTab {
  @State allNews: NewsItem[] = [];
  @State filteredNews: NewsItem[] = [];
  @State activeCategory: string = '全部';
  @State categories: string[] = ['全部', '学术', '校园', '通知', '荣誉'];
  @State isLoading: boolean = true;

  async aboutToAppear(): Promise<void> {
    await this.loadData();
  }

  async loadData(): Promise<void> {
    try {
      this.isLoading = true;
      const list = await getNewsList();
      this.allNews = this.normalizeNews(list);
      this.applyFilter();
    } catch (error) {
      console.error('NewsTab 加载失败：' + JSON.stringify(error));
      this.loadMockData();
    } finally {
      this.isLoading = false;
    }
  }

  normalizeNews(list: NewsItem[]): NewsItem[] {
    return list.map((item: NewsItem) => {
      const result: NewsItem = {
        id: item.id,
        title: item.title,
        summary: item.summary,
        content: item.content,
        category: this.getCategoryLabel(item.category),
        publishDate: this.formatDate(item.publishDate),
        author: item.author,
        tags: item.tags,
        viewCount: item.viewCount,
        isTop: item.isTop,
        status: item.status
      };
      return result;
    });
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

  loadMockData(): void {
    const mockNews1: NewsItem = { id: 1, title: '我校科研团队获国家重点研发计划立项', summary: '计算机科学与生命科学交叉研究团队成功获批国家重点研发计划项目。', category: '学术', publishDate: '2026-07-10' };
    const mockNews2: NewsItem = { id: 2, title: '第十二届校园文化艺术节圆满落幕', summary: '历时两周的校园文化艺术节吸引了近万名师生参与。', category: '校园', publishDate: '2026-07-05' };
    const mockNews3: NewsItem = { id: 3, title: '2026年秋季学期开学安排公告', summary: '2026年秋季学期将于9月1日正式开学，新生报到时间为8月28日至30日。', category: '通知', publishDate: '2026-06-28' };
    const mockNews4: NewsItem = { id: 4, title: '我校学生在全国大学生数学建模竞赛中获佳绩', summary: '6 支队伍获得全国一等奖，12 支队伍获得全国二等奖。', category: '荣誉', publishDate: '2026-06-20' };
    const mockNews5: NewsItem = { id: 5, title: '牛犇大学-华为联合实验室揭牌成立', summary: '双方将在 5G/6G 通信、边缘计算和智能终端等领域展开深度合作。', category: '学术', publishDate: '2026-06-15' };
    const mockNews6: NewsItem = { id: 6, title: '校园美食节精彩来袭', summary: '来自全国各地 50 多种特色美食齐聚校园。', category: '校园', publishDate: '2026-06-10' };
    const mockNews7: NewsItem = { id: 7, title: '关于暑期校园施工安全的通知', summary: '暑期期间部分教学楼将进行维修改造，请注意施工区域的安全提示。', category: '通知', publishDate: '2026-06-05' };
    const mockNews8: NewsItem = { id: 8, title: '校友企业家返校分享创业经验', summary: '20 余位成功创业校友重返母校，与在校学子分享创业历程和行业洞察。', category: '校园', publishDate: '2026-06-01' };
    const mockNews9: NewsItem = { id: 9, title: '我校教授入选国家"万人计划"', summary: '计算机学院张明远教授、材料学院王建国教授入选国家高层次人才特殊支持计划。', category: '荣誉', publishDate: '2026-05-25' };
    this.allNews = [mockNews1, mockNews2, mockNews3, mockNews4, mockNews5, mockNews6, mockNews7, mockNews8, mockNews9];
    this.applyFilter();
  }

  applyFilter(): void {
    if (this.activeCategory === '全部') {
      this.filteredNews = this.allNews;
    } else {
      this.filteredNews = this.allNews.filter((n: NewsItem) => n.category === this.activeCategory);
    }
  }

  onCategoryChange(cat: string): void {
    this.activeCategory = cat;
    this.applyFilter();
  }

  getCategoryColor(cat: string): string {
    const map: Record<string, string> = {
      '学术': '#2563EB',
      '校园': '#16A34A',
      '通知': '#D97706',
      '荣誉': '#9333EA'
    };
    return map[cat] || '#0F766E';
  }

  goToDetail(item: NewsItem): void {
    router.pushUrl({
      url: 'pages/NewsDetailPage',
      params: { id: item.id, newsData: item }
    });
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({ angle: 180, colors: [['#134E4A', 0.0], ['#0F766E', 1.0]] })
        Column() {
          Text('新闻动态')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
          Text('了解牛犇大学最新资讯')
            .fontSize(12)
            .fontColor('#E6FFFA')
            .margin({ top: 6 })
        }
      }
      .width('100%')
      .height(120)
      .clip(true)

      Scroll() {
        Row({ space: 8 }) {
          ForEach(this.categories, (cat: string) => {
            Text(cat)
              .fontSize(12)
              .padding({ left: 14, right: 14, top: 6, bottom: 6 })
              .borderRadius(20)
              .backgroundColor(this.activeCategory === cat ? '#0F766E' : '#F1F5F9')
              .fontColor(this.activeCategory === cat ? '#FFFFFF' : '#64748B')
              .onClick(() => { this.onCategoryChange(cat); })
          }, (cat: string) => cat)
        }
        .padding({ left: 12, right: 12 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
      .margin({ top: 10, bottom: 8 })

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
      } else {
        Scroll() {
          Column() {
            ForEach(this.filteredNews, (item: NewsItem) => {
              Column() {
                Row({ space: 6 }) {
                  Text(item.category)
                    .fontSize(10)
                    .fontColor('#FFFFFF')
                    .backgroundColor(this.getCategoryColor(item.category))
                    .borderRadius(4)
                    .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                  Text(item.publishDate)
                    .fontSize(10)
                    .fontColor('#94A3B8')
                }
                .margin({ bottom: 6 })

                Text(item.title)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1E293B')
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .margin({ bottom: 4 })

                Text(item.summary)
                  .fontSize(11)
                  .fontColor('#64748B')
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
              }
              .width('100%')
              .padding(12)
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
              .margin({ left: 12, right: 12, bottom: 8 })
              .onClick(() => { this.goToDetail(item); })
            }, (item: NewsItem) => item.id.toString())
          }
          .padding({ bottom: 20 })
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Auto)
        .layoutWeight(1)
        .backgroundColor('#F8FAFC')
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}
