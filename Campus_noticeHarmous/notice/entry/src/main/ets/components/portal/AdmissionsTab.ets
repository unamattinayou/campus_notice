interface AdmissionItem {
  id: number;
  title: string;
  status: string;
  description: string;
  quota: string;
  duration: string;
  deadline: string;
}

interface ScoreLine {
  year: string;
  science: string;
  arts: string;
}

@Component
export struct AdmissionsTab {
  @State activeTab: string = 'undergraduate';
  @State admissionItems: Record<string, AdmissionItem[]> = {
    'undergraduate': [
      { id: 1, title: '2026年普通本科招生', status: '招生中', description: '面向全国 31 个省份招收本科生，涵盖 68 个专业方向，计划招生 5,200 人。实行"分数优先、遵循志愿"的录取原则。', quota: '5,200', duration: '4年', deadline: '6月25日-7月5日' },
      { id: 2, title: '强基计划招生', status: '已截止', description: '面向基础学科拔尖学生，选拔数学、物理、化学、生物、历史、哲学等方向的优秀学子，实行本硕博衔接培养。', quota: '180', duration: '4+2+3年', deadline: '4月10日-4月30日' },
      { id: 3, title: '艺术类本科招生', status: '招生中', description: '涵盖美术设计、音乐表演、舞蹈编导等方向，需参加省级艺术统考及我校校考。', quota: '350', duration: '4年', deadline: '2月15日-3月15日' }
    ],
    'graduate': [
      { id: 4, title: '2026年全国硕士研究生招生', status: '招生中', description: '学术型与专业型并重，覆盖 96 个硕士点。推荐免试生和全国统考两种途径。', quota: '3,200', duration: '2-3年', deadline: '10月5日-25日' },
      { id: 5, title: '非全日制硕士招生', status: '招生中', description: '面向在职人员，MBA、MPA、教育硕士等专业方向灵活学习。', quota: '800', duration: '2.5年', deadline: '10月5日-25日' }
    ],
    'doctoral': [
      { id: 6, title: '2026年博士研究生"申请-考核"制', status: '招生中', description: '面向已获得硕士学位的优秀申请者，通过材料审核和综合考核择优录取。', quota: '450', duration: '3-4年', deadline: '11月1日-30日' },
      { id: 7, title: '直博生招生', status: '已截止', description: '面向本校及"双一流"高校优秀本科毕业生，直接攻读博士学位。', quota: '120', duration: '5年', deadline: '9月1日-20日' }
    ]
  };
  @State admissionTabs: string[] = ['undergraduate', 'graduate', 'doctoral'];
  @State admissionTabLabels: Record<string, string> = {
    'undergraduate': '本科',
    'graduate': '硕士',
    'doctoral': '博士'
  };
  @State scoreLines: ScoreLine[] = [
    { year: '2025', science: '628', arts: '601' },
    { year: '2024', science: '621', arts: '595' },
    { year: '2023', science: '615', arts: '588' }
  ];

  getCurrentItems(): AdmissionItem[] {
    return this.admissionItems[this.activeTab] || [];
  }

  build() {
    Column() {
      // Banner
      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({ angle: 180, colors: [['#134E4A', 0.0], ['#0F766E', 1.0]] })
        Column() {
          Text('招生就业')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
          Text('开启你的大学之旅')
            .fontSize(12)
            .fontColor('#E6FFFA')
            .margin({ top: 6 })
        }
      }
      .width('100%')
      .height(120)
      .clip(true)

      // Quick Entries
      Row() {
        Column() {
          Text('本科').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#0F766E')
          Text('招生简章').fontSize(10).fontColor('#64748B').margin({ top: 2 })
        }.layoutWeight(1).alignItems(HorizontalAlign.Center)
        Column() {
          Text('硕士').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#0F766E')
          Text('硕博申请').fontSize(10).fontColor('#64748B').margin({ top: 2 })
        }.layoutWeight(1).alignItems(HorizontalAlign.Center)
        Column() {
          Text('国际').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#0F766E')
          Text('留学生').fontSize(10).fontColor('#64748B').margin({ top: 2 })
        }.layoutWeight(1).alignItems(HorizontalAlign.Center)
        Column() {
          Text('就业').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#0F766E')
          Text('就业报告').fontSize(10).fontColor('#64748B').margin({ top: 2 })
        }.layoutWeight(1).alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#FFFFFF')
      .margin({ bottom: 8 })

      // Content List
      Scroll() {
        Column() {
          // Tabs
          Row() {
            ForEach(this.admissionTabs, (tab: string) => {
              Text(this.admissionTabLabels[tab])
                .fontSize(13)
                .fontWeight(this.activeTab === tab ? FontWeight.Bold : FontWeight.Normal)
                .fontColor(this.activeTab === tab ? '#0F766E' : '#64748B')
                .padding({ left: 16, right: 16, top: 10, bottom: 10 })
                .border({ width: { bottom: 2 }, color: { bottom: this.activeTab === tab ? '#0F766E' : Color.Transparent } })
                .onClick(() => { this.activeTab = tab; })
            }, (tab: string) => tab)
          }
          .width('100%')
          .backgroundColor('#FFFFFF')
          .margin({ bottom: 8 })

          // Admission Items
          ForEach(this.getCurrentItems(), (item: AdmissionItem) => {
            Column() {
              Row() {
                Text(item.title)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1E293B')
                  .layoutWeight(1)
                Text(item.status)
                  .fontSize(10)
                  .fontColor(item.status === '招生中' ? '#16A34A' : '#0F766E')
                  .backgroundColor(item.status === '招生中' ? '#F0FDF4' : '#F0FDFA')
                  .borderRadius(10)
                  .padding({ left: 8, right: 8, top: 2, bottom: 2 })
              }
              .width('100%')
              .margin({ bottom: 6 })

              Text(item.description)
                .fontSize(11)
                .fontColor('#64748B')
                .maxLines(3)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .margin({ bottom: 6 })

              Row({ space: 12 }) {
                Text(`计划：${item.quota}`).fontSize(10).fontColor('#94A3B8')
                Text(`学制：${item.duration}`).fontSize(10).fontColor('#94A3B8')
                Text(`截止：${item.deadline}`).fontSize(10).fontColor('#94A3B8')
              }
            }
            .width('100%')
            .padding(12)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .margin({ bottom: 8, left: 12, right: 12 })
          }, (item: AdmissionItem) => item.id.toString())

          // Score Lines
          Column() {
            Text('历年分数线')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor('#0F766E')
              .margin({ bottom: 8 })

            ForEach(this.scoreLines, (score: ScoreLine) => {
              Row() {
                Text(score.year).fontSize(12).fontColor('#64748B').layoutWeight(1)
                Text(`理科 ${score.science}`).fontSize(12).fontColor('#1E293B').layoutWeight(1).textAlign(TextAlign.Center)
                Text(`文科 ${score.arts}`).fontSize(12).fontColor('#1E293B').layoutWeight(1).textAlign(TextAlign.Center)
              }
              .width('100%')
              .padding({ top: 6, bottom: 6 })
              .border({ width: { bottom: 0.5 }, color: { bottom: '#E2E8F0' } })
            }, (score: ScoreLine) => score.year)
          }
          .width('100%')
          .padding(12)
          .backgroundColor('#F0FDFA')
          .borderRadius(12)
          .margin({ left: 12, right: 12, bottom: 20 })

          // Employment Stats
          Column() {
            Text('就业服务')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
              .margin({ bottom: 10 })

            Row() {
              Column() {
                Text('96.8%').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
                Text('就业率').fontSize(10).fontColor('#CCFBF1').margin({ top: 2 })
              }.layoutWeight(1).alignItems(HorizontalAlign.Center)
              Column() {
                Text('45.2%').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
                Text('深造率').fontSize(10).fontColor('#CCFBF1').margin({ top: 2 })
              }.layoutWeight(1).alignItems(HorizontalAlign.Center)
              Column() {
                Text('Top 500').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
                Text('雇主覆盖').fontSize(10).fontColor('#CCFBF1').margin({ top: 2 })
              }.layoutWeight(1).alignItems(HorizontalAlign.Center)
            }
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#0F766E')
          .borderRadius(12)
          .margin({ left: 12, right: 12, bottom: 20 })
        }
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Auto)
      .layoutWeight(1)
      .backgroundColor('#F8FAFC')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}
