import { getPublishedNotices, searchNotices, Notice } from '../http/noticeApi';
import router from '@ohos.router';
import { SearchBar } from '../components/SearchBar';
import { CategoryTab } from '../components/CategoryTab';
import { NoticeList } from '../components/NoticeList';
// import { NoticeDetail } from '../components/NoticeDetail';

@Entry
@Component
struct AnnouncementMainPage {
  @State searchKey: string = "";
  @State selectedCategory: string = "全部";
  // @State currentDetailId: number | null = null;
  @State announcementList: Notice[] = [];
  @State isRefreshing: boolean = false; // 刷新状态
  // @State detailInfo: Notice = {
  //   id: 0,
  //   title: "",
  //   content: "",
  //   summary: "",
  //   category: "",
  //   priority: "",
  //   status: "",
  //   publisherId: 0,
  //   publisherName: "",
  //   publishTime: "",
  //   isTop: 0,
  //   viewCount: 0,
  //   attachmentUrl: null,
  //   isDeleted: 0,
  //   createTime: "",
  //   updateTime: ""
  // };
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
        // ✅ 映射真实后端字段讲座
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

  // showDetail(item: Notice): void {
  //   this.detailInfo = item;
  //   this.currentDetailId = item.id;
  // }
  goToDetail(item: Notice): void {
    router.pushUrl({
      url: 'pages/NoticeDetailPage',
      params: {
        noticeData: item // 把当前公告整条数据传给详情页
      }
    })
  }

  // backToList(): void {
  //   this.currentDetailId = null;
  // }

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
        // ✅ 显示中文标签
        categoryList: ["全部", "通知", "行政", "学术"],
        originCategory: this.selectedCategory,
        onCategoryChange: (value: string) => {
          // ✅ 中文标签 → 映射后端原始字段
          let realCat = "";
          if(value === "通知") realCat = "NOTICE";
          else if(value === "行政") realCat = "ADMIN";
          else if(value === "学术") realCat = "ACADEMIC";
          else realCat = ""; //全部

          this.selectedCategory = value; //UI显示中文
          this.loadAnnouncementData();
        }
      })

      // if (this.isLoading) {
      //   Text("加载中...")
      //     .fontSize(16)
      //     .margin({ top: 20 })
      // } else if (this.loadError !== "") {
      //   Text(this.loadError)
      //     .fontSize(14)
      //     .fontColor(Color.Red)
      //     .margin({ top: 20 })
      // }
      // else if (this.currentDetailId === null) {
      //   NoticeList({
      //     list: this.announcementList,
      //     onItemClick: (item: Notice) => {
      //       this.showDetail(item);
      //     }
      //   })
      // } else {
      //   NoticeDetail({
      //     data: this.detailInfo,
      //     onBack: () => {
      //       this.backToList();
      //      }
      //    })
      // }
      // 原来的 if(currentDetailId === null) 整个判断删掉，直接写NoticeList
      NoticeList({
        list: this.announcementList,
        onItemClick: (item: Notice) => {
          this.goToDetail(item);
        }
      })

    }
    .padding(16)
    .width('100%')
    .height('100%')
    .backgroundColor('#f8f8f8')
  }
}