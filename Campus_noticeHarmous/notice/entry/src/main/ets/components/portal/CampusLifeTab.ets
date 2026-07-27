interface HighlightCard {
  id: number;
  title: string;
  desc: string;
  color: string;
}

interface OrganizationCategory {
  id: number;
  name: string;
  count: number;
  color: string;
}

interface Facility {
  id: number;
  name: string;
  desc: string;
  color: string;
}

interface Testimonial {
  id: number;
  name: string;
  major: string;
  year: string;
  quote: string;
  color: string;
}

@Component
export struct CampusLifeTab {
  @State highlightCards: HighlightCard[] = [
    { id: 1, title: '学生社团', desc: '200+社团涵盖学术、文化、体育、公益等领域，总有适合你的舞台', color: '#0F766E' },
    { id: 2, title: '体育竞技', desc: '校级运动队 20+ 支，省级赛事多次获奖，体育精神融入校园文化', color: '#16A34A' },
    { id: 3, title: '文化艺术', desc: '音乐节、话剧季、书法展、摄影大赛，让文艺之花绽放校园', color: '#9333EA' },
    { id: 4, title: '志愿服务', desc: '年志愿服务超 10,000 人次，践行社会责任，传递温暖力量', color: '#DC2626' }
  ];
  @State organizationCategories: OrganizationCategory[] = [
    { id: 1, name: '学术科技', count: 65, color: '#2563EB' },
    { id: 2, name: '文化艺术', count: 52, color: '#9333EA' },
    { id: 3, name: '体育竞技', count: 38, color: '#16A34A' },
    { id: 4, name: '公益服务', count: 45, color: '#DC2626' }
  ];
  @State facilities: Facility[] = [
    { id: 1, name: '现代化图书馆', desc: '藏书 300 万册，24 小时自习区，智能检索系统', color: '#2563EB' },
    { id: 2, name: '智能学生公寓', desc: '四人间标配独立卫浴、空调、热水，自助洗衣', color: '#16A34A' },
    { id: 3, name: '多元餐饮服务', desc: '6 个学生食堂，涵盖中西餐、清真、地方特色', color: '#D97706' },
    { id: 4, name: '全校园 WiFi', desc: '5G 网络全覆盖，万兆光纤到桌面', color: '#4F46E5' },
    { id: 5, name: '综合体育馆', desc: '游泳馆、篮球馆、羽毛球馆、健身房一应俱全', color: '#DC2626' },
    { id: 6, name: '创新创业空间', desc: '大学生创业孵化基地，共享工位、路演厅、导师资源', color: '#9333EA' }
  ];
  @State testimonials: Testimonial[] = [
    { id: 1, name: '林小琳', major: '计算机科学', year: '2024级', quote: '在这里我找到了热爱——加入机器人社团后，我从零学会了硬件编程，还和团队一起拿下了全国机器人大赛一等奖。', color: '#2563EB' },
    { id: 2, name: '陈志远', major: '经济管理', year: '2023级', quote: '学校给了我们很多实践机会，创业孵化基地让我把商业计划变成了真正的创业项目。校园生活的每一天都很充实。', color: '#16A34A' },
    { id: 3, name: '王思涵', major: '艺术设计', year: '2024级', quote: '我最喜欢的是校园的文艺氛围，从书法社到话剧团，每个学期都有新的惊喜。这里的图书馆也是我最爱去的地方。', color: '#9333EA' }
  ];

  build() {
    Column() {
      // Banner
      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({ angle: 180, colors: [['#134E4A', 0.0], ['#0F766E', 1.0]] })
        Column() {
          Text('校园生活')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
          Text('丰富多彩的校园文化，塑造全面发展的人格')
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
          // Highlight Cards
          Text('校园风采')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#134E4A')
            .margin({ left: 12, bottom: 8, top: 12 })

          ForEach(this.highlightCards, (card: HighlightCard) => {
            Column() {
              Text(card.title)
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .fontColor(card.color)
                .margin({ bottom: 4 })
              Text(card.desc)
                .fontSize(11)
                .fontColor('#64748B')
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
            .width('100%')
            .padding(12)
            .backgroundColor('#FFFFFF')
            .border({ width: { left: 3 }, color: { left: card.color } })
            .borderRadius(8)
            .margin({ left: 12, right: 12, bottom: 6 })
          }, (card: HighlightCard) => card.id.toString())

          // Organization Categories
          Text('学生社团')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#134E4A')
            .margin({ left: 12, bottom: 8, top: 12 })

          Row() {
            ForEach(this.organizationCategories, (org: OrganizationCategory) => {
              Column() {
                Text(org.count.toString())
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(org.color)
                Text(org.name)
                  .fontSize(10)
                  .fontColor('#64748B')
                  .margin({ top: 2 })
                Text('个社团')
                  .fontSize(9)
                  .fontColor('#94A3B8')
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Center)
              .padding(10)
              .backgroundColor('#FFFFFF')
              .borderRadius(8)
              .margin({ left: 4, right: 4 })
            }, (org: OrganizationCategory) => org.id.toString())
          }
          .width('100%')
          .padding({ left: 8, right: 8 })
          .margin({ bottom: 8 })

          // Facilities
          Text('校园设施')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#134E4A')
            .margin({ left: 12, bottom: 8, top: 12 })

          ForEach(this.facilities, (facility: Facility) => {
            Row() {
              Column()
                .width(4)
                .height(40)
                .backgroundColor(facility.color)
                .borderRadius(2)
                .margin({ right: 10 })

              Column() {
                Text(facility.name)
                  .fontSize(13)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1E293B')
                Text(facility.desc)
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
            .borderRadius(8)
            .margin({ left: 12, right: 12, bottom: 6 })
          }, (facility: Facility) => facility.id.toString())

          // Testimonials
          Text('学子心声')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#134E4A')
            .margin({ left: 12, bottom: 8, top: 12 })

          ForEach(this.testimonials, (t: Testimonial) => {
            Column() {
              Row() {
                Text(t.name.charAt(0))
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#FFFFFF')
                  .backgroundColor(t.color)
                  .borderRadius(20)
                  .width(36)
                  .height(36)
                  .textAlign(TextAlign.Center)
                  .margin({ right: 10 })

                Column() {
                  Text(t.name)
                    .fontSize(13)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#1E293B')
                  Text(`${t.major} · ${t.year}`)
                    .fontSize(10)
                    .fontColor('#94A3B8')
                    .margin({ top: 2 })
                }
                .alignItems(HorizontalAlign.Start)
              }
              .width('100%')
              .margin({ bottom: 8 })

              Text(`"${t.quote}"`)
                .fontSize(11)
                .fontColor('#64748B')
                .fontStyle(FontStyle.Italic)
                .maxLines(4)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
            .width('100%')
            .padding(12)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .margin({ left: 12, right: 12, bottom: 8 })
          }, (t: Testimonial) => t.id.toString())
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
