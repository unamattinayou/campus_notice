import { getPublishedNotices, searchNotices, Notice } from '../../http/noticeApi';
import router from '@ohos.router';
import { SearchBar } from '../SearchBar';
import { CategoryTab } from '../CategoryTab';
import { NoticeList } from '../NoticeList';
import { categoryLabelList, getRealCategory } from '../CategoryMap';

@Component
export struct SearchTab {
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
}