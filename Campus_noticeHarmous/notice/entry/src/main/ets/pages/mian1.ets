import router from '@ohos.router';
import { getPublishedNotices, searchNotices, Notice } from '../http/noticeApi';
import { SearchBar } from '../components/SearchBar';
import { CategoryTab } from '../components/CategoryTab';
import { NoticeList } from '../components/NoticeList';
import { categoryLabelList, getRealCategory } from '../components/CategoryMap';

@Entry
@Component
struct MainPage {
  // 底部Tab索引：0=主页 1=查询 2=分布图
  @State currentTab: number = 0;
  private tabsController: TabsController = new TabsController();

  // ========== 轮播图配置（主页用）==========
  @State bannerList: Resource[] = [
    $r('app.media.sidi'),
    $r('app.media.sishui'),
    $r('app.media.qingshui')
  ];

  // ========== 公告列表配置（查询页用）==========
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

  goToDetail(item: Notice): void {
    router.pushUrl({
      url: 'pages/NoticeDetailPage',
      params: { noticeData: item }
    })
  }

  aboutToAppear(): void {
    this.loadAnnouncementData();
  }

  build() {
    Column() {
      // ========== 中间内容区（切换只变这里，底部不动）==========
      Tabs({
        barPosition: BarPosition.End,
        controller: this.tabsController
      }) {
        // Tab1：主页
        TabContent() {
          Column() {
            Text("校园公告查询系统")
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .width("100%")
              .textAlign(TextAlign.Center)
              .padding({ top: 16, bottom: 16 })

            Swiper() {
              ForEach(this.bannerList, (item: Resource, index: number) => {
                Image(item)
                  .width("100%")
                  .height(160)
                  .objectFit(ImageFit.Cover)
                  .borderRadius(12)
              })
            }
            .autoPlay(true)
            .interval(3000)
            .loop(true)
            .width("100%")
            .padding({ left: 16, right: 16 })

            Text("欢迎使用校园公告查询系统\n下拉浏览最新校园通知")
              .fontSize(16)
              .fontColor("#666666")
              .textAlign(TextAlign.Center)
              .margin({ top: 30 })

            Blank()
          }
          .width('100%')
          .height('100%')
          .backgroundColor('#f8f8f8')
        }

        // Tab2：查询页（原Index2全部内容）
        TabContent() {
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
              categoryList: categoryLabelList, // 直接用导入的数组，不用重复写
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
                  this.goToDetail(item);
                }
              })
            }
            .onRefreshing(() => {
              this.onPullRefresh();
            })
            .layoutWeight(1)
          }
          .padding(16)
          .width('100%')
          .height('100%')
          .backgroundColor('#f8f8f8')
        }

        // Tab3：分布图页（后续补充内容即可）
        TabContent() {
          Column() {
            Text("公告分布图")
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .padding({ top: 20 })
            Blank()
          }
          .width('100%')
          .height('100%')
          .backgroundColor('#f8f8f8')
        }
      }
      .layoutWeight(1)
      .onChange((index: number) => {
        this.currentTab = index;
      })
      // 隐藏系统默认Tab栏，用我们自定义的底部导航
      .barHeight(0)

      // ========== 底部固定导航栏（永远不动）==========
      Row() {
        Button("主页", { type: ButtonType.Normal, stateEffect:true })
          .layoutWeight(1)
          .fontSize(16)
          .backgroundColor(this.currentTab === 0 ? "#007DFF" : Color.White)
          .fontColor(this.currentTab === 0 ? Color.White : Color.Black)
          .onClick(()=>{
            this.currentTab = 0;
            this.tabsController.changeIndex(0);
          })

        Button("查询", { type: ButtonType.Normal, stateEffect:true })
          .layoutWeight(1)
          .fontSize(16)
          .backgroundColor(this.currentTab === 1 ? "#007DFF" : Color.White)
          .fontColor(this.currentTab === 1 ? Color.White : Color.Black)
          .onClick(()=>{
            this.currentTab = 1;
            this.tabsController.changeIndex(1);
          })

        Button("分布图", { type: ButtonType.Normal, stateEffect:true })
          .layoutWeight(1)
          .fontSize(16)
          .backgroundColor(this.currentTab === 2 ? "#007DFF" : Color.White)
          .fontColor(this.currentTab === 2 ? Color.White : Color.Black)
          .onClick(()=>{
            this.currentTab = 2;
            this.tabsController.changeIndex(2);
          })
      }
      .width("100%")
      .height(60)
      .backgroundColor(Color.White)
    }
    .width("100%")
    .height("100%")
  }
}