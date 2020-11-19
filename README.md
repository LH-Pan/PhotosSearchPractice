# PhotosSearchPractice

開啟專案後先行設定環境：建立 git、在 GitHub 創立新的 repo、於 Terminal 建立 .gitigonre 條件並且套用後連結本地與遠端 repo 即開始實作本次練習。

根據此次練習需求先行安裝下列 Cocoapods Third Party:

- **IQKeyboardManagerSwift**
  
> 讓 TextField 點擊並彈出鍵盤時畫面可同時往上適量地滑動，使鍵盤不會擋住輸入框
  
- **Alamofire**

> 發送網路訊息時套用至網路層，可使發送 reqeust 部分的程式碼較具有可讀性，若將來有需要使用到監控網路狀態的功能時，此套件也能夠很便利地達到目的
  
- **SnapKit**

> 將純 code 繪製畫面的繁瑣簡單化，讓設定 constraints 時能夠使用更少的程式碼及具有較佳的可讀性
  
- **Kingfisher**

> 較為泛用的套件之一，可簡易地讀取網路圖片，同時可將讀取過的圖片將 url 作為 Key 寫入 cache，下次讀取相同 url 會先去 cache 找有的話會直接轉為圖片，可節省再發送一次 request 讀取圖片的時間。

- **MJRefresh**

> 適用於需要更新或加載資料情境的套件

- **SwiftLint**

> 程式碼規範檢查工具，藉由條件規範 Coding Style

此練習不使用 Storyboard，故於開始實作前直接將 Main.storyboard 刪除，並將專案 Targets -> General 的 Main Interface 設為空值，使用的模擬器為 iPhone11。

預設畫面刪除後需指定新的 window，因版本 13 以上會優先進入 SceneDelegate，低於 13 版本則直接進入 AppDelegate，故兩邊都寫入判斷版本以及指定 rootViewController 為自定義的 TabBarController

TabBar 頁面依指定需求分為兩個 item： Featured 及 Favorite，在 PSTabBarController 中建立 Navigation 的 enum 與帶有此 enum 參數進而生成 NavigationController 的 method。

指定需求中使用的 Navigation Bar 款式皆相同，故自定義 PSNavigationController 並於 viewDidLoad 做好相關設定，於 TabBarController 中調用時便可不用分別設定一次。

**兩個分頁其主要功能分為以下頁面： (架構皆為 MVVM)**

1. 搜尋頁面 -> 搜尋結果頁面:

  - 搜尋頁面: 
    - 畫面皆由 Controller 負責，故生成輸入搜尋關鍵字、每頁搜尋數量的 TextField 及前往搜尋結果頁面的按鈕，並在 controller 中設定 constraints
    - 考量到這個畫面會有 allowSearch 及 disallowSearch 的情況，將這兩種狀態利用 enum 定義為 State，此頁面共會用到兩個 TextField 的字串及 state 的資料
    - 資料皆由 ViewModel 負責，因此 ViewModel 會擁有兩個 String 及 State 的 property，利用 Access Control 將資料設為 private，僅限自己能夠更改，需開源給外部使用時則建立 compute property，可使資料僅能讀取
    - 建立更改資料的 method，數量的資料則先判斷是否為數字，若不是數字則觸發 notNumberAlertClosure
    - 兩個字串資料皆使用 property observer 的 did set 來偵測是否有值的變動，有的話先判斷是否皆為合法的資料，若合法則將 State 更改為 allowSearch，否則改為 disallowSearch
    - 更改了 State 再藉由 did set 觸發 changeStateClosure 將 State 傳出去，最後於 controller 實作 viewModel 的 closure 以執行 DataBinding
    - Controller 根據 changeStateClosure 傳過來的 state 來設定按鈕是否為允許點選的狀態，若為可點擊則點擊後跳轉至搜尋結果頁面
    - 跳轉頁面時需生成搜尋結果頁面的 controller，又因自定義初始化 controller 需外部注入 viewModel，故在此時將 search item、limit 同時注入 viewModel 再匯入 controller 中
    
  - 搜尋結果頁面:
    - 生成 Collection View 給予自定義 UICollectionViewFlowLayout，設定 constraints 並 conform UICollectionViewDatasource 及 UICollectionViewDelegate
    - 建立 Collection View Cell xib 並與 class 連結 IBOutlet 與 IBAction，並宣告屬於 cell 自己 ViewModel 的 struct，在其 instance 的 didSet 中更新對應資料的畫面
    - 建立 ViewModel 並在初始化時利用寫好的網路層將從搜尋頁面匯入的參數(search item、limit)發送 request，並將得到的 response 結果轉為 cellViewModel 的陣列，建立以 index 為參數得到對應位置 cellViewModel 的 method 與 cell 綁定
    - cellViewModel 的陣列偵測到值的變動進入 didSet 與 oldValue 數量做比較，若為上拉加載新資料數量較多，則將新舊資料經 insertCellsClosure 傳出去，若為下拉更新資料較少則經 reloadDataClosure 通知 controller 資料有大幅更動
    - 建立 CoreData 資料庫，為了存入被點選加入收藏的資料，建立 Entity 並設立欲存入的資料與型態，開源 Create、Read、Delete 的 method，且宣告可經由 KVO 監聽的資料，每次更新資料都會重新讀取並發送監聽
    - 點選 Cell 的加入收藏經由自定義的 delegate 將自己與圖片傳出去，controller conform Cell 的 Delegate 藉由實作 method 來得到 cell 在 collection view 的 index 以及圖片，再藉由 viewModel 更改對應的 cell 選取狀態，若選取則將資料存入 CoreData，若取消選取則藉由資料帶有唯一值的 id 作為索引將資料取出後刪除
    
2. 我的最愛頁面
    - 生成 Collection View 給予自定義 UICollectionViewFlowLayout，設定 constraints 並 conform UICollectionViewDatasource 及 UICollectionViewDelegate
    - 建立 Collection View Cell xib 並與 class 連結 IBOutlet 與 IBAction，並宣告屬於 cell 自己 ViewModel 的 struct，在其 instance 的 didSet 中更新對應資料的畫面
    - 建立 ViewModel 並在初始化時生成一個監聽 CoreData 資料的 observer，並在資料回來的 call back 中將資料轉為此頁面使用的 cellViewModel
    - cellViewModel 陣列資料更動時進入 did set 觸發 reloadDataClosure 通知與之 Data Binding 的 controller 有資料更新了
    - 因監聽的關係，在搜尋結果頁面新增刪除改動資料庫也會同步改變在最愛頁面中的資料


**若時間允許仍可繼續優化的部分：**

1. 可以自定義一個 Observable 的 class，建立符合自己需求的 method，讓與之 data binding 的物件可分別實作自己想做的事情，較直接進入 did set 有架構性，binding 時也較清楚是哪個值的變動
2. CoreData 目前針對圖片的存取為保存圖片的 data，但已經使用了 Kingfisher 套件應善用該套件能夠 cache 的特性，故可將 data 改轉為存入圖片的 URL 字串
3. 使用過多套件可能造成維護不易，例如下拉更新或是 IQKeyboard 應該可以自己實作，網路層也可以使用原生的 URLSession
4. 搜尋結果頁面應該也可定義當前畫面的 state，藉由 state 判斷應該要有怎麼樣的行為有益於加強可讀性
5. 搜尋結果頁面及我的最愛頁面 UI 設計雷同，或許可以改寫為重用同一個 View Class 或是利用繼承的特性來區別兩者小地方的不同，以便提升程式碼的擴充性



