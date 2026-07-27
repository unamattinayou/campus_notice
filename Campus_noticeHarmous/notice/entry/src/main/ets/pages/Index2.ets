import { getPublishedNotices, searchNotices, Notice } from '../http/noticeApi';
import router from '@ohos.router';
import { SearchBar } from '../components/SearchBar';
import { CategoryTab } from '../components/CategoryTab';
import { NoticeList } from '../components/NoticeList';

@Entry
@Component
struct AnnouncementMainPage {
  @State searchKey: string = "";
  @State selectedCategory: string = "全部";
  @State announcementList: Notice[] = [];
  @State isRefreshing: boolean = false;
  @State isLoading: boolean = true;
  @State loadError: string = "";
  @State activeTab: string = "search";

  async loadAnnouncementData(): Promise<void> {
    try {
      this.isLoading = true;
      this.loadError = "";
      let list: Notice[] = [];
      if (this.searchKey === "" && this.selectedCategory === "全部") {
        list = await getPublishedNotices();
      } else {
        let realCat = "";
        if(this.selectedCategory === "通知") realCat = "NOTICE";
        else if(this.selectedCategory === "行政") realCat = "ADMIN";
        else if(this.selectedCategory === "学术") realCat = "ACADEMIC";
        else realCat = "";

        list = await searchNotices(this.searchKey, realCat);
      }
      this.announcementList = list;
    } catch (error) {
      this.loadError = "加载失败：" + JSON.stringify(error);
      console.error(this.loadError);
    } finally {
      this.isLoading = false;
    }
  }

  onPullRefresh(): void {
    if (this.isRefreshing) return; // 防止重复触发元旦
    this.isRefreshing = true;
    this.loadAnnouncementData().finally(() => {
      this.isRefreshing = false;
    });
  }

  goToDetail(item: Notice): void {
    router.pushUrl({
      url: 'pages/NoticeDetailPage',
      params: {
        noticeData: item
      }
    })
  }

  aboutToAppear(): void {
    this.loadAnnouncementData();
  }

  build() {
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
        categoryList: ["全部", "通知", "行政", "学术"],
        originCategory: this.selectedCategory,
        onCategoryChange: (value: string) => {
          let realCat = "";
          if(value === "通知") realCat = "NOTICE";
          else if(value === "行政") realCat = "ADMIN";
          else if(value === "学术") realCat = "ACADEMIC";
          else realCat = "";

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
      // ✅ 列表区域自适应填充，给底部Tab留出位置
      .layoutWeight(1)


      // ========== 新增底部导航栏 ==========
      // Row() {
      //   Button("主页", { type: ButtonType.Normal, stateEffect:true })
      //     .layoutWeight(1)
      //     .fontSize(16)
      //     .backgroundColor(Color.White)
      //     .fontColor(Color.Black)
      //     .onClick(()=>{
      //       this.activeTab = "home";
      //       router.pushUrl({url:"pages/mian"})
      //     })
      //
      //   Button("查询", { type: ButtonType.Normal, stateEffect:true })
      //     .layoutWeight(1)
      //     .fontSize(16)
      //     .backgroundColor(Color.White)
      //     .fontColor(Color.Black)
      //     .onClick(()=>{
      //       // 跳转到【查询页面】，替换为你的页面路径
      //       this.activeTab = "search";
      //       // router.pushUrl({url:"pages/Index2"})
      //     })
      //
      //   Button("分布图", { type: ButtonType.Normal, stateEffect:true })
      //     .layoutWeight(1)
      //     .fontSize(16)
      //     .backgroundColor(Color.White)
      //     .fontColor(Color.Black)
      //     .onClick(()=>{
      //       // 跳转到【分布图页面】，替换为你的页面路径
      //       router.pushUrl({url:"pages/ChartPage"})
      //     })
      // }
      // .width("100%")
      // .height(60)
      // .backgroundColor(Color.White)
    }
    .padding(16)
    .width('100%')
    .height('100%')
    .backgroundColor('#f8f8f8')
  }





}