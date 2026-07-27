interface ResearchPlatform {
  id: number;
  name: string;
  level: string;
  description: string;
  director: string;
  members: number;
}

interface ResearchArea {
  id: number;
  name: string;
  description: string;
  tags: string[];
}

interface Achievement {
  id: number;
  date: string;
  type: string;
  title: string;
  description: string;
}

@Component
export struct ResearchTab {
  @State platforms: ResearchPlatform[] = [
    { id: 1, name: '人工智能与大数据国家重点实验室', level: '国家级', description: '聚焦机器学习、计算机视觉、自然语言处理等基础理论突破与产业应用', director: '张明远 教授', members: 85 },
    { id: 2, name: '生物医药交叉创新中心', level: '省部级', description: '推动 AI 赋能药物发现、基因编辑和精准医疗领域的交叉创新研究', director: '李文华 教授', members: 62 },
    { id: 3, name: '先进材料与绿色能源研究院', level: '省部级', description: '在新型功能材料、固态电池、光伏器件等方向取得系列突破', director: '王建国 教授', members: 48 },
    { id: 4, name: '智慧城市与数字治理研究中心', level: '省部级', description: '利用大数据和 AI 技术推动城市治理现代化与数字化转型', director: '陈思远 教授', members: 35 },
    { id: 5, name: '文化创意与数字媒体实验室', level: '校级', description: '探索传统文化数字化保护与数字媒体内容创新', director: '刘雅婷 教授', members: 22 },
    { id: 6, name: '生物多样性与生态修复研究所', level: '省部级', description: '聚焦濒危物种保护、生态系统修复和可持续发展研究', director: '赵文博 教授', members: 30 }
  ];
  @State researchAreas: ResearchArea[] = [
    { id: 1, name: '人工智能与机器学习', description: '在深度学习理论、大语言模型、计算机视觉等方向持续产出高水平成果', tags: ['深度学习', 'NLP', '计算机视觉'] },
    { id: 2, name: '生物医药工程', description: '利用 AI 技术加速药物发现，在蛋白质结构预测、分子对接等方向取得重要进展', tags: ['药物发现', '基因编辑', '精准医疗'] },
    { id: 3, name: '新能源与先进材料', description: '在钙钛矿太阳能电池、固态电解质、碳纳米材料等领域拥有多项核心专利', tags: ['太阳能电池', '储能材料', '纳米技术'] },
    { id: 4, name: '数字经济与社会治理', description: '运用大数据分析方法研究数字经济运行规律与社会治理创新模式', tags: ['数字经济', '数据治理', '智慧城市'] }
  ];
  @State achievements: Achievement[] = [
    { id: 1, date: '2026-06', type: '论文', title: 'Nature 发文：AI 辅助药物筛选新方法', description: '计算机科学与生命科学交叉研究团队在 Nature 主刊发表研究论文，提出基于图神经网络的小分子药物筛选新方法，效率提升 50 倍。' },
    { id: 2, date: '2026-03', type: '项目', title: '获批国家重点研发计划项目', description: '人工智能与大数据国家重点实验室成功获批国家重点研发计划项目，资助经费 3,200 万元。' },
    { id: 3, date: '2025-12', type: '奖项', title: '国家科技进步二等奖', description: '先进材料团队凭借"高性能钙钛矿太阳能电池关键技术"项目荣获国家科技进步二等奖。' },
    { id: 4, date: '2025-09', type: '论文', title: 'Science 发文：量子计算新突破', description: '物理与材料科学交叉团队在 Science 发表论文，实现了 128 量子比特的稳定纠缠态。' }
  ];

  getLevelColor(level: string): string {
    if (level === '国家级') return '#DC2626';
    if (level === '省部级') return '#0F766E';
    return '#64748B';
  }

  getTypeColor(type: string): string {
    if (type === '论文') return '#2563EB';
    if (type === '项目') return '#16A34A';
    return '#D97706';
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
          Text('科学研究')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
          Text('面向国家战略需求，推动基础研究与应用创新深度融合')
            .fontSize(12)
            .fontColor('#E6FFFA')
            .margin({ top: 6 })
        }
      }
      .width('100%')
      .height(120)
      .clip(true)

      Scroll() {
        Column() {
          // Stats
          Row() {
            Column() {
              Text('6').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#0F766E')
              Text('国家级平台').fontSize(10).fontColor('#64748B').margin({ top: 2 })
            }.layoutWeight(1).alignItems(HorizontalAlign.Center)
            Column() {
              Text('28').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#0F766E')
              Text('省部级平台').fontSize(10).fontColor('#64748B').margin({ top: 2 })
            }.layoutWeight(1).alignItems(HorizontalAlign.Center)
            Column() {
              Text('1,200+').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#0F766E')
              Text('SCI 论文').fontSize(10).fontColor('#64748B').margin({ top: 2 })
            }.layoutWeight(1).alignItems(HorizontalAlign.Center)
            Column() {
              Text('8.5亿').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#0F766E')
              Text('科研经费').fontSize(10).fontColor('#64748B').margin({ top: 2 })
            }.layoutWeight(1).alignItems(HorizontalAlign.Center)
          }
          .width('100%')
          .padding(12)
          .backgroundColor('#FFFFFF')
          .margin({ bottom: 8 })

          // Platforms
          Text('科研平台')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#134E4A')
            .margin({ left: 12, bottom: 8, top: 8 })

          ForEach(this.platforms, (platform: ResearchPlatform) => {
            Column() {
              Row() {
                Text(platform.level)
                  .fontSize(10)
                  .fontColor('#FFFFFF')
                  .backgroundColor(this.getLevelColor(platform.level))
                  .borderRadius(4)
                  .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                Text(platform.name)
                  .fontSize(13)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1E293B')
                  .layoutWeight(1)
                  .margin({ left: 8 })
              }
              .width('100%')
              .margin({ bottom: 6 })

              Text(platform.description)
                .fontSize(11)
                .fontColor('#64748B')
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .margin({ bottom: 6 })

              Row({ space: 12 }) {
                Text(platform.director).fontSize(10).fontColor('#94A3B8')
                Text(`${platform.members} 名研究人员`).fontSize(10).fontColor('#94A3B8')
              }
            }
            .width('100%')
            .padding(12)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .margin({ left: 12, right: 12, bottom: 8 })
          }, (platform: ResearchPlatform) => platform.id.toString())

          // Research Areas
          Text('重点研究领域')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#134E4A')
            .margin({ left: 12, bottom: 8, top: 12 })

          ForEach(this.researchAreas, (area: ResearchArea) => {
            Column() {
              Text(area.name)
                .fontSize(13)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1E293B')
                .margin({ bottom: 4 })
              Text(area.description)
                .fontSize(11)
                .fontColor('#64748B')
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .margin({ bottom: 6 })

              Row({ space: 6 }) {
                ForEach(area.tags, (tag: string) => {
                  Text(tag)
                    .fontSize(10)
                    .fontColor('#64748B')
                    .backgroundColor('#F1F5F9')
                    .borderRadius(8)
                    .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                }, (tag: string) => tag)
              }
            }
            .width('100%')
            .padding(12)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .margin({ left: 12, right: 12, bottom: 8 })
          }, (area: ResearchArea) => area.id.toString())

          // Achievements
          Text('科研亮点')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#134E4A')
            .margin({ left: 12, bottom: 8, top: 12 })

          ForEach(this.achievements, (item: Achievement) => {
            Column() {
              Row({ space: 8 }) {
                Text(item.date)
                  .fontSize(11)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0F766E')
                Text(item.type)
                  .fontSize(10)
                  .fontColor('#FFFFFF')
                  .backgroundColor(this.getTypeColor(item.type))
                  .borderRadius(4)
                  .padding({ left: 6, right: 6, top: 2, bottom: 2 })
              }
              .margin({ bottom: 4 })

              Text(item.title)
                .fontSize(13)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1E293B')
                .margin({ bottom: 4 })

              Text(item.description)
                .fontSize(11)
                .fontColor('#64748B')
                .maxLines(3)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
            .width('100%')
            .padding(12)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .margin({ left: 12, right: 12, bottom: 8 })
          }, (item: Achievement) => item.id.toString())
        }
        .padding({ bottom: 20 })
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
