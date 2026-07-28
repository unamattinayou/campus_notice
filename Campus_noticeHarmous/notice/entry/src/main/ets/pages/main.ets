import router from '@ohos.router';
import { HomePortalTab } from '../components/portal/HomePortalTab';
import { DepartmentsTab } from '../components/portal/DepartmentsTab';
import { AdmissionsTab } from '../components/portal/AdmissionsTab';
import { ResearchTab } from '../components/portal/ResearchTab';
import { CampusLifeTab } from '../components/portal/CampusLifeTab';
import { ChartTab } from '../components/tabs/ChartTab';
import { getPublishedNotices, searchNotices, Notice } from '../http/noticeApi';
import { SearchBar } from '../components/SearchBar';
import { CategoryTab } from '../components/CategoryTab';
import { NoticeList } from '../components/NoticeList';
import { categoryLabelList, getRealCategory } from '../components/CategoryMap';

@Entry
@Component
struct MainPage {
  @State currentTab: number = 0;
  private tabsController: TabsController = new TabsController();
  private tabLabels: string[] = ['首页', '院系', '招生', '科研', '生活', '公告', '分布', '我的'];

  @State searchKey: string = "";
  @State selectedCategory: string = "全部";
  @State announcementList: Notice[] = [];
  @State isRefreshing: boolean = false;
  @State isLoading: boolean = true;
  @State loadError: string = "";

  async loadAnnouncementData(): Promise<void> {
    try {
      this.isLoading = true;
      this.loadError = "";
      let list: Notice[] = [];
      if (this.searchKey === "" && this.selectedCategory === "全部") {
        list = await getPublishedNotices();
      } else {
        const realCat: string = getRealCategory(this.selectedCategory);
        list = await searchNotices(this.searchKey, realCat);
      }
      this.announcementList = list;
    } catch (error) {
      this.loadError = "加载失败：" + JSON.stringify(error);
      console.error(this.loadError);
    } finally {
      this.isLoading = false;
      this.isRefreshing = false;
    }
  }

  onPullRefresh(): void {
    if (this.isRefreshing) return;
    this.isRefreshing = true;
    this.loadAnnouncementData();
  }

  goToNoticeDetail(item: Notice): void {
    router.pushUrl({
      url: 'pages/NoticeDetailPage',
      params: { noticeData: item }
    })
  }

  aboutToAppear(): void {
    this.loadAnnouncementData();
  }

  onTabChange(index: number): void {
    this.currentTab = index;
    this.tabsController.changeIndex(index);
    if (index === 6) {
      this.loadAnnouncementData();
    }
  }

  @Builder
  NoticeQueryContent() {
    Column() {
      // 顶部 Banner：统一校园门户风格
      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({ angle: 180, colors: [['#134E4A', 0.0], ['#0F766E', 1.0]] })
        Column() {
          Text('校园公告')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
          Text('第一时间掌握校园最新通知与动态')
            .fontSize(12)
            .fontColor('#E6FFFA')
            .margin({ top: 6 })
        }
      }
      .width('100%')
      .height(110)
      .clip(true)

      // 搜索 + 分类 + 列表
      Column() {
        SearchBar({
          originSearchKey: this.searchKey,
          onSearchChange: (value: string) => {
            this.searchKey = value;
            setTimeout(() => {
              this.loadAnnouncementData();
            }, 300);
          }
        })

        CategoryTab({
          categoryList: categoryLabelList,
          originCategory: this.selectedCategory,
          onCategoryChange: (value: string) => {
            this.selectedCategory = value;
            this.loadAnnouncementData();
          }
        })

        Refresh({
          refreshing: this.isRefreshing,
          offset: 60
        }) {
          NoticeList({
            list: this.announcementList,
            onItemClick: (item: Notice) => {
              this.goToNoticeDetail(item);
            }
          })
        }
        .onRefreshing(() => {
          this.onPullRefresh();
        })
        .layoutWeight(1)
      }
      .padding(12)
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#F8FAFC')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }

  @Builder
  ProfileContent() {
    Scroll() {
      Column({ space: 12 }) {
        Column() {
          Column() {
            Text('牛')
              .fontSize(36)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
          }
          .width(80)
          .height(80)
          .borderRadius(40)
          .backgroundColor('#0F766E')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)

          Text('同学你好')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E293B')
            .margin({ top: 10 })

          Text('欢迎来到牛犇大学校园门户')
            .fontSize(12)
            .fontColor('#64748B')
            .margin({ top: 4 })
        }
        .width('100%')
        .padding({ top: 30, bottom: 20 })
        .alignItems(HorizontalAlign.Center)
        .linearGradient({
          angle: 180,
          colors: [['#F0FDFA', 0.0], ['#FFFFFF', 1.0]]
        })

        Column({ space: 8 }) {
          Row() {
            Text('我的公告收藏')
              .fontSize(14)
              .fontColor('#1E293B')
              .layoutWeight(1)
            Text('>')
              .fontSize(16)
              .fontColor('#94A3B8')
          }
          .width('100%')
          .padding(14)
          .backgroundColor('#FFFFFF')
          .borderRadius(10)
          .onClick(() => {
            this.onTabChange(6);
          })

          Row() {
            Text('浏览历史')
              .fontSize(14)
              .fontColor('#1E293B')
              .layoutWeight(1)
            Text('>')
              .fontSize(16)
              .fontColor('#94A3B8')
          }
          .width('100%')
          .padding(14)
          .backgroundColor('#FFFFFF')
          .borderRadius(10)

          Row() {
            Text('设置')
              .fontSize(14)
              .fontColor('#1E293B')
              .layoutWeight(1)
            Text('>')
              .fontSize(16)
              .fontColor('#94A3B8')
          }
          .width('100%')
          .padding(14)
          .backgroundColor('#FFFFFF')
          .borderRadius(10)

          Row() {
            Text('关于我们')
              .fontSize(14)
              .fontColor('#1E293B')
              .layoutWeight(1)
            Text('>')
              .fontSize(16)
              .fontColor('#94A3B8')
          }
          .width('100%')
          .padding(14)
          .backgroundColor('#FFFFFF')
          .borderRadius(10)
        }
        .width('92%')
        .margin({ top: 8, bottom: 30 })
      }
      .width('100%')
    }
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Auto)
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }

  build() {
    Column() {
      Row() {
        Text(this.tabLabels[this.currentTab])
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#0F766E')
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)

      Tabs({
        barPosition: BarPosition.End,
        controller: this.tabsController
      }) {
        TabContent() { HomePortalTab() }
        TabContent() { DepartmentsTab() }
        TabContent() { AdmissionsTab() }
        TabContent() { ResearchTab() }
        TabContent() { CampusLifeTab() }
        TabContent() { this.NoticeQueryContent() }
        TabContent() { ChartTab() }
        TabContent() { this.ProfileContent() }
      }
      .layoutWeight(1)
      .onChange((index: number) => {
        this.currentTab = index;
        if (index === 6) {
          this.loadAnnouncementData();
        }
      })
      .barHeight(0)

      Row() {
        ForEach(this.tabLabels, (label: string, index: number) => {
          Column() {
            Text(this.getTabIcon(index))
              .fontSize(16)
              .fontColor(this.currentTab === index ? '#0F766E' : '#94A3B8')
            Text(label)
              .fontSize(11)
              .fontColor(this.currentTab === index ? '#0F766E' : '#94A3B8')
              .margin({ top: 2 })
          }
          .layoutWeight(1)
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .onClick(() => {
            this.onTabChange(index);
          })
        }, (label: string, index: number) => label + index.toString())
      }
      .width('100%')
      .height(56)
      .backgroundColor('#FFFFFF')
      .border({ width: { top: 1 }, color: '#E2E8F0' })
    }
    .width('100%')
    .height('100%')
  }

  getTabIcon(index: number): string {
    const icons: string[] = ['⌂', '∄', '✎', '⚛', '★', '⚙','📊', '◉'];
    return icons[index] || '•';
  }
}
