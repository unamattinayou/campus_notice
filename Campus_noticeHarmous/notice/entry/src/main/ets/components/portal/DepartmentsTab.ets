import { getSchoolInfo, SchoolInfo } from '../../http/portalApi';

interface Department {
  id: number;
  code: string;
  name: string;
  category: string;
  description: string;
  facultyCount: number;
  programCount: number;
}

@Component
export struct DepartmentsTab {
  @State departments: Department[] = [];
  @State activeCategory: string = '全部';
  @State categories: string[] = ['全部', '理学', '工学', '文学', '管理学', '艺术学'];
  @State schoolInfo: SchoolInfo | null = null;
  @State isLoading: boolean = true;

  aboutToAppear(): void {
    this.loadMockData();
    this.loadSchoolInfo();
  }

  async loadSchoolInfo(): Promise<void> {
    try {
      this.schoolInfo = await getSchoolInfo();
    } catch (error) {
      this.schoolInfo = { id: 1, name: '牛犇大学', address: '北京市海淀区学院路100号', phone: '010-62888888' };
    } finally {
      this.isLoading = false;
    }
  }

  loadMockData(): void {
    this.departments = [
      { id: 1, code: 'CS', name: '计算机科学与技术学院', category: '工学', description: '聚焦人工智能、大数据与软件工程，培养面向未来的技术创新人才', facultyCount: 180, programCount: 8 },
      { id: 2, code: 'EE', name: '电子工程学院', category: '工学', description: '涵盖微电子、通信工程、集成电路设计等前沿方向，产学研深度融合', facultyCount: 150, programCount: 7 },
      { id: 3, code: 'CE', name: '土木工程学院', category: '工学', description: '在智能建造、绿色建筑等领域享有盛誉', facultyCount: 120, programCount: 5 },
      { id: 4, code: 'ME', name: '机械工程学院', category: '工学', description: '融合智能制造与机器人技术，建设先进制造实验室', facultyCount: 110, programCount: 5 },
      { id: 5, code: 'EC', name: '经济管理学院', category: '管理学', description: '融合经济学与管理学前沿理论，注重实践与国际化视野', facultyCount: 160, programCount: 9 },
      { id: 6, code: 'SC', name: '数学与统计学院', category: '理学', description: '基础数学与应用数学并重，数据科学与人工智能交叉研究特色鲜明', facultyCount: 90, programCount: 4 },
      { id: 7, code: 'LS', name: '生命科学学院', category: '理学', description: '从基因到生态，探索生命奥秘，推动生物医药前沿突破', facultyCount: 130, programCount: 6 },
      { id: 8, code: 'CH', name: '化学与材料学院', category: '理学', description: '在新型功能材料、绿色化学等领域拥有国际领先的研究成果', facultyCount: 100, programCount: 5 },
      { id: 9, code: 'LC', name: '文学与传播学院', category: '文学', description: '传承人文精神，在数字时代探索文学创作与传媒创新', facultyCount: 85, programCount: 6 },
      { id: 10, code: 'LW', name: '法学院', category: '文学', description: '培养德法兼修的高素质法律人才，聚焦数字法治与知识产权', facultyCount: 70, programCount: 4 },
      { id: 11, code: 'AD', name: '艺术设计学院', category: '艺术学', description: '融合传统美学与现代设计理念，激发创造力与审美表达', facultyCount: 65, programCount: 5 },
      { id: 12, code: 'MU', name: '音乐与舞蹈学院', category: '艺术学', description: '传承经典艺术教育，创新音乐表演与舞蹈编创教学模式', facultyCount: 55, programCount: 4 }
    ];
  }

  getFilteredDepartments(): Department[] {
    if (this.activeCategory === '全部') return this.departments;
    return this.departments.filter((d: Department) => d.category === this.activeCategory);
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
          Text('院系设置')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
          Text('涵盖文理工商艺等多个学科门类')
            .fontSize(12)
            .fontColor('#E6FFFA')
            .margin({ top: 6 })
        }
      }
      .width('100%')
      .height(120)
      .clip(true)

      // Stats
      Row() {
        Column() {
          Text('12').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#0F766E')
          Text('学院').fontSize(10).fontColor('#64748B')
        }.layoutWeight(1).alignItems(HorizontalAlign.Center)
        Column() {
          Text('68').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#0F766E')
          Text('系/研究所').fontSize(10).fontColor('#64748B')
        }.layoutWeight(1).alignItems(HorizontalAlign.Center)
        Column() {
          Text('156').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#0F766E')
          Text('本硕博专业').fontSize(10).fontColor('#64748B')
        }.layoutWeight(1).alignItems(HorizontalAlign.Center)
        Column() {
          Text('2,800').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#0F766E')
          Text('教职员工').fontSize(10).fontColor('#64748B')
        }.layoutWeight(1).alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#FFFFFF')
      .margin({ bottom: 8 })

      // Category Filter
      Scroll() {
        Row({ space: 8 }) {
          ForEach(this.categories, (cat: string) => {
            Text(cat)
              .fontSize(12)
              .padding({ left: 14, right: 14, top: 6, bottom: 6 })
              .borderRadius(20)
              .backgroundColor(this.activeCategory === cat ? '#0F766E' : '#F1F5F9')
              .fontColor(this.activeCategory === cat ? '#FFFFFF' : '#64748B')
              .onClick(() => { this.activeCategory = cat; })
          }, (cat: string) => cat)
        }
        .padding({ left: 12, right: 12 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
      .margin({ bottom: 8 })

      // Department List
      Scroll() {
        Column() {
          ForEach(this.getFilteredDepartments(), (dept: Department) => {
            Row() {
              Text(dept.code)
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#0F766E')
                .backgroundColor('#CCFBF1')
                .borderRadius(12)
                .width(56)
                .height(56)
                .textAlign(TextAlign.Center)
                .margin({ right: 12 })

              Column() {
                Row({ space: 6 }) {
                  Text(dept.category)
                    .fontSize(10)
                    .fontColor('#0F766E')
                    .backgroundColor('#CCFBF1')
                    .borderRadius(4)
                    .padding(2)
                  Text(dept.name)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#1E293B')
                    .layoutWeight(1)
                }
                .margin({ bottom: 4 })

                Text(dept.description)
                  .fontSize(11)
                  .fontColor('#64748B')
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .margin({ bottom: 4 })

                Row({ space: 12 }) {
                  Text(`${dept.facultyCount} 名教师`).fontSize(10).fontColor('#94A3B8')
                  Text(`${dept.programCount} 个专业`).fontSize(10).fontColor('#94A3B8')
                }
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .padding(12)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .margin({ bottom: 8 })
          }, (dept: Department) => dept.id.toString())
        }
        .padding({ left: 12, right: 12, bottom: 20 })
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
