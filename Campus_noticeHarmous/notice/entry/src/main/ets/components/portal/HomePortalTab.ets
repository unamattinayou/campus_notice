import router from '@ohos.router';
import {
  getHomePageData,
  HomePageData,
  Stat,
  AcademicProgram,
  CampusLifeFeature,
  NewsItem,
  SchoolInfo
} from '../../http/portalApi';

@Component
export struct HomePortalTab {
  @State stats: Stat[] = [];
  @State academicPrograms: AcademicProgram[] = [];
  @State campusLifeFeatures: CampusLifeFeature[] = [];
  @State news: NewsItem[] = [];
  @State schoolInfo: SchoolInfo | null = null;
  @State isLoading: boolean = true;
  @State loadError: string = "";

  async aboutToAppear(): Promise<void> {
    await this.loadData();
  }

  async loadData(): Promise<void> {
    try {
      this.isLoading = true;
      this.loadError = "";
      const data: HomePageData = await getHomePageData();
      this.stats = data.stats || [];
      this.academicPrograms = data.academicPrograms || [];
      this.campusLifeFeatures = data.campusLifeFeatures || [];
      this.news = (data.news || []).slice(0, 5);
      this.schoolInfo = data.schoolInfo || null;
    } catch (error) {
      console.error('HomePortalTab 加载失败：' + JSON.stringify(error));
      this.loadMockData();
    } finally {
      this.isLoading = false;
    }
  }

  loadMockData(): void {
    this.stats = [
      { id: 1, statKey: 'history_years', statValue: '70', statLabel: '年办学历史' },
      { id: 2, statKey: 'student_count', statValue: '35000', statLabel: '在校学生' },
      { id: 3, statKey: 'faculty_count', statValue: '2800', statLabel: '教职员工' },
      { id: 4, statKey: 'degree_programs', statValue: '156', statLabel: '硕博学位点' }
    ];
    this.academicPrograms = [
      { id: 1, code: 'CS', name: '计算机科学', description: '聚焦人工智能、大数据与软件工程，培养面向未来的技术创新人才' },
      { id: 2, code: 'EM', name: '经济管理', description: '融合经济学与管理学前沿理论，注重实践与国际化视野' },
      { id: 3, code: 'LC', name: '文学与传播', description: '传承人文精神，在数字时代探索文学创作与传媒创新' },
      { id: 4, code: 'LS', name: '生命科学', description: '从基因到生态，探索生命奥秘，推动生物医药前沿突破' }
    ];
    this.campusLifeFeatures = [
      { id: 1, title: '学生社团', description: '200+社团涵盖学术、文化、体育、公益等领域' },
      { id: 2, title: '体育竞技', description: '省级赛事多次获奖，体育精神融入校园文化' },
      { id: 3, title: '志愿服务', description: '参与公益项目，践行社会责任，传递温暖力量' }
    ];
    this.news = [
      { id: 1, title: '我校科研团队获国家重点研发计划立项', summary: '计算机科学与生命科学交叉研究团队成功获批国家重点研发计划项目。', category: 'ACADEMIC', publishDate: '2026-07-10' },
      { id: 2, title: '第十二届校园文化艺术节圆满落幕', summary: '历时两周的校园文化艺术节吸引了近万名师生参与。', category: 'ADMIN', publishDate: '2026-07-05' },
      { id: 3, title: '2026年秋季学期开学安排公告', summary: '2026年秋季学期将于9月1日正式开学。', category: 'NOTICE', publishDate: '2026-06-28' }
    ];
    this.schoolInfo = { id: 1, name: '牛犇大学', address: '北京市海淀区学院路100号', phone: '010-62888888' };
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

  goToNewsDetail(item: NewsItem): void {
    router.pushUrl({
      url: 'pages/NewsDetailPage',
      params: { id: item.id }
    });
  }

  @Builder
  HeroSection() {
    Stack({ alignContent: Alignment.Center }) {
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [['#0F766E', 0.0], ['#134E4A', 1.0]]
        })
      Column() {
        Text('在这里，遇见未来')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .textAlign(TextAlign.Center)
          .margin({ bottom: 12 })
        Text('探索知识的边界，成就卓越的人生')
          .fontSize(14)
          .fontColor('#E6FFFA')
          .textAlign(TextAlign.Center)
          .margin({ bottom: 20 })
        Row({ space: 12 }) {
          Button('了解详情', { type: ButtonType.Capsule })
            .fontSize(14)
            .backgroundColor('#FFFFFF')
            .fontColor('#0F766E')
            .height(40)
          Button('虚拟校园', { type: ButtonType.Capsule })
            .fontSize(14)
            .backgroundColor(Color.Transparent)
            .fontColor('#FFFFFF')
            .border({ width: 1.5, color: '#FFFFFF' })
            .height(40)
        }
      }
    }
    .width('100%')
    .height(220)
    .borderRadius(16)
    .clip(true)
    .margin({ bottom: 16 })
  }

  @Builder
  StatsSection() {
    Column() {
      Text('学校概览')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#134E4A')
        .margin({ bottom: 10 })

      ForEach(this.stats, (stat: Stat) => {
        Row() {
          Column() {
            Text(stat.statValue + '+')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#0F766E')
            Text(stat.statLabel)
              .fontSize(11)
              .fontColor('#64748B')
              .margin({ top: 4 })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)
        }
      }, (stat: Stat) => stat.id.toString())
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#F0FDFA')
    .borderRadius(12)
    .margin({ bottom: 16 })
  }

  @Builder
  AcademicProgramsSection() {
    Column() {
      Text('学术项目')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#134E4A')
        .margin({ bottom: 10 })

      ForEach(this.academicPrograms, (program: AcademicProgram) => {
        Row() {
          Text(program.code)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .backgroundColor('#0F766E')
            .borderRadius(8)
            .padding(8)
            .width(40)
            .height(40)
            .textAlign(TextAlign.Center)
            .margin({ right: 10 })

          Column() {
            Text(program.name)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1E293B')
            Text(program.description)
              .fontSize(11)
              .fontColor('#64748B')
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .margin({ top: 2 })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .padding(10)
        .backgroundColor('#FFFFFF')
        .borderRadius(10)
        .margin({ bottom: 8 })
      }, (program: AcademicProgram) => program.id.toString())
    }
    .width('100%')
    .margin({ bottom: 16 })
  }

  @Builder
  CampusLifeSection() {
    Column() {
      Text('校园生活')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#134E4A')
        .margin({ bottom: 10 })

      ForEach(this.campusLifeFeatures, (feature: CampusLifeFeature) => {
        Row() {
          Column() {
            Text(feature.title)
              .fontSize(13)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1E293B')
            Text(feature.description)
              .fontSize(11)
              .fontColor('#64748B')
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .margin({ top: 2 })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .padding(10)
        .backgroundColor('#FFFFFF')
        .borderRadius(10)
        .margin({ bottom: 6 })
      }, (feature: CampusLifeFeature) => feature.id.toString())
    }
    .width('100%')
    .margin({ bottom: 16 })
  }

  @Builder
  NewsSection() {
    Column() {
      Row() {
        Text('新闻动态')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#134E4A')
        Blank()
        Text('查看全部 >')
          .fontSize(12)
          .fontColor('#0F766E')
      }
      .width('100%')
      .margin({ bottom: 10 })

      ForEach(this.news, (item: NewsItem) => {
        Row() {
          Column() {
            Text(item.title)
              .fontSize(13)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1E293B')
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
            Row({ space: 6 }) {
              Text(this.getCategoryLabel(item.category))
                .fontSize(10)
                .fontColor('#0F766E')
                .backgroundColor('#CCFBF1')
                .borderRadius(4)
                .padding(2)
              Text(item.publishDate)
                .fontSize(10)
                .fontColor('#94A3B8')
            }
            .margin({ top: 4 })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .padding(10)
        .backgroundColor('#FFFFFF')
        .borderRadius(10)
        .margin({ bottom: 6 })
        .onClick(() => { this.goToNewsDetail(item); })
      }, (item: NewsItem) => item.id.toString())
    }
    .width('100%')
    .margin({ bottom: 16 })
  }

  @Builder
  AdmissionsCTASection() {
    Column() {
      Text('准备好开始了吗？')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .margin({ bottom: 8 })
      Text('立即在线申请，加入牛犇大学，开启你的人生新篇章')
        .fontSize(12)
        .fontColor('#E6FFFA')
        .textAlign(TextAlign.Center)
        .margin({ bottom: 16 })
      Button('在线申请', { type: ButtonType.Capsule })
        .fontSize(14)
        .backgroundColor('#FFFFFF')
        .fontColor('#0F766E')
        .height(40)
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#0F766E')
    .borderRadius(16)
    .alignItems(HorizontalAlign.Center)
  }

  build() {
    Scroll() {
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
          .height(300)
          .justifyContent(FlexAlign.Center)
        } else {
          this.HeroSection()
          this.StatsSection()
          this.AcademicProgramsSection()
          this.CampusLifeSection()
          this.NewsSection()
          this.AdmissionsCTASection()
        }
      }
      .width('100%')
      .padding(12)
    }
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Auto)
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}
