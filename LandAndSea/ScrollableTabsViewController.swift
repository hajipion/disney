
import UIKit

class ScrollableTabsViewController: CommonViewController, UIScrollViewDelegate {
    
    /* ------------------------ 宣言 --------------------------*/
    
    @IBOutlet weak var scrollViewHeader: UIScrollView!
    @IBOutlet weak var scrollViewMain: UIScrollView!
    
    // エリアID
    var areaID: Int = 0
    
    // 選択されているタブ
    var tabSelected: String = ""
    
    // エリアデータ
    var areaName:[String] = []
    
    // アトラクションデータ
    var attractionName:[NSArray] = []
    
    // 待ち時間
    var waitingTime:[NSArray] = []
    
    // 平均待ち時間
    var averageTime:[NSArray] = []
    
    // ファストパスの帯
    var fastpassExisting:[NSArray] = []
    
    // ファストパスの時間
    var fastpassTime:[NSArray] = []
    
    // ショーの名前
    var showName:[NSArray] = []
    
    // ショーの時間
    var showTime:[NSArray] = []
    
    // ショーの場所
    var showArea:[NSArray] = []
    
    // ページ数
    var pageSize:Int = 0
    
    // ヘッダーの下線
    var borderOfHeader: UIView!
    
    // コレクションビュー
    var collectionView : UICollectionView!
    
    // テーブルビュー
    var listTableView: UITableView!
    
    // 間隔
    var intervalPage: CGFloat = 1.9
    
    // カレントバーのアニメーション秒数
    var durationSecond: Double = 0
    
    // カレントバーの係数
    var currentBarWidthCoefficient: CGFloat = 20
    
    // カレントバーの幅
    var currentBarWidth: CGFloat = 0
    
    // カレントバー生成
    var currentBar:UIView = UIView(frame: CGRectZero)
    
    // カードのフェードインを許可するトリガー
    var cardFadeInTrigger:Bool = true
    
    // ロードされたページ
    var pageLoaded:Int = 0
    
    /* ------------------------ ビュー --------------------------*/
    
    // カードビュー全体を生成
    func createScrollableTabsView() {
        
        // ページ数を各エリア数と同じにする
        pageSize = areaName.count
        
        // 画面サイズの取得
        let screenSize = measureScreenSize()
        let width = screenSize.width
        let height = screenSize.height
        
        // カレントバー幅の初期値
        currentBarWidth = CGFloat(count(areaName[0])) * currentBarWidthCoefficient
        
        // ヘッダービューを生成
        createHeaderView(width, height: height, currentBarWidth: currentBarWidth)
        
        // メインビューを生成
        createMainView(width, height: height)
        
        // ヘッダーコンテンツを生成
        createHeaderContents(width, height: height)
        
        // メインコンテンツを生成
        createMainContents(width, height: height, currentPage: 0)
        
    }
    
    // カレントバーをアップデート
    func updateCurrentBar(width: CGFloat, height: CGFloat, currentBarWidth: CGFloat, firstLoad: Bool) {
        
        if !firstLoad {
            durationSecond = 0.2
        }
        
        UIView.animateWithDuration(durationSecond) {
            self.currentBar.frame = CGRectMake(0, 0, currentBarWidth, 4)
            
            // 複数行エリアタイトルの対応
            if (self.tabSelected == "Sea") {
                if ( self.areaID == 0 ) {
                    self.currentBar.frame = CGRectMake(0, 0, 150, 4)
                }
                if ( self.areaID == 6 ) {
                    self.currentBar.frame = CGRectMake(0, 0, 210, 4)
                }
            }
            self.currentBar.layer.position = CGPointMake(self.view.frame.width/2, 94)
            self.currentBar.backgroundColor = self.UIColorFromRGB(0xEA7777)
            
            self.view.addSubview(self.currentBar)
        }
        
    }
    
    // ヘッダービューを生成
    func createHeaderView(width: CGFloat, height: CGFloat, currentBarWidth: CGFloat) {
        
        // ScrollViewHeaderの設定.
        scrollViewHeader.showsHorizontalScrollIndicator = false
        scrollViewHeader.showsVerticalScrollIndicator = false
        scrollViewHeader.pagingEnabled = true
        scrollViewHeader.delegate = self
        scrollViewHeader.backgroundColor = UIColor.whiteColor()
        scrollViewHeader.contentSize = CGSizeMake(CGFloat(pageSize) * width, scrollViewHeader.frame.size.height)
        
        // ヘッダーの下線を生成
        borderOfHeader = UIView(frame: CGRectMake(-200, scrollViewHeader.frame.size.height - 0.3, scrollViewHeader.frame.size.width * CGFloat(pageSize) + 200, 2))
        borderOfHeader.backgroundColor = UIColorFromRGB(0x979797)
        borderOfHeader.alpha = 0.3
        self.scrollViewHeader.addSubview(self.borderOfHeader)
        
        // カレントバー初期値
        updateCurrentBar(width, height: height, currentBarWidth: currentBarWidth, firstLoad: true)
        
    }
    
    // メインビューを生成
    func createMainView(width: CGFloat, height: CGFloat) {
        
        // ScrollViewMainの設定.
        scrollViewMain.showsHorizontalScrollIndicator = false
        scrollViewMain.showsVerticalScrollIndicator = false
        scrollViewMain.pagingEnabled = true
        scrollViewMain.delegate = self
        scrollViewMain.backgroundColor = UIColorFromRGB(0xF1F1F1)
        scrollViewMain.contentSize = CGSizeMake(CGFloat(pageSize) * width, 0)
        
    }
    
    // ヘッダーコンテンツを生成
    func createHeaderContents(width: CGFloat, height: CGFloat) {
        
        for var i = 0; i < pageSize; i++ {
            
            //ページごとに異なる画像を表示
            let areaImageWidth = CGFloat(62)
            let areaImageHeight = CGFloat(47)
            let areaImageView: UIImageView = UIImageView(frame: CGRectMake(CGFloat(i) * width/1.9 + width/2 - areaImageWidth/2, 20, areaImageWidth, areaImageHeight))
            let areaImage = UIImage(named: "\(tabSelected)Section\(i).png")
            areaImageView.image = areaImage
            
            //ページごとに異なるラベルを表示
            let areaName:UILabel = UILabel(frame: CGRectMake((CGFloat(i) * width)/intervalPage + width/2 - width/2, 60, width, 40))
            areaName.numberOfLines = 0
            areaName.textColor = UIColorFromRGB(0xEA7777)
            
            // エリアタイトルの設定
            areaName.text = self.areaName[i]
            
            // 行間の変更
            let lineHeight:CGFloat = 12.0
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.minimumLineHeight = lineHeight
            paragraphStyle.maximumLineHeight = lineHeight
            let attributedText = NSMutableAttributedString(string: areaName.text!)
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
            areaName.attributedText = attributedText
            
            areaName.font = UIFont(name: "FolkPro-Regular", size: 15)
            areaName.textAlignment = NSTextAlignment.Center
            
            // 複数行エリアタイトルの対応
            if (tabSelected == "Sea") {
                if ( i == 0 ) {
                    areaName.font = UIFont(name: "FolkPro-Regular", size: 13)
                    areaName.layer.position.y = 78
                }
            }
            
            scrollViewHeader.addSubview(areaImageView)
            scrollViewHeader.addSubview(areaName)
            
        }
        
    }
    
    // メインコンテンツを生成
    func createMainContents(width: CGFloat, height: CGFloat, currentPage: Int) {
    }
    
    
    /* ------------------------ ファンクション --------------------------*/
    
    // エリアが移動しているときに呼ばれる.
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if scrollView == scrollViewMain {
            
            // エリアタイトルの位置を調整
            scrollViewHeader.contentOffset.x = scrollViewMain.contentOffset.x/intervalPage
            
            // 現在のページを計算
            var pageWidth : CGFloat = self.scrollViewMain.frame.size.width
            var fractionalPage : Double = Double(self.scrollViewMain.contentOffset.x / pageWidth)
            var page : NSInteger = lround(fractionalPage)
            
            // 画面サイズの取得
            let screenSize = measureScreenSize()
            let width = screenSize.width
            let height = screenSize.height
            
            // カレントバー更新
            currentBarWidth = CGFloat(count(areaName[page])) * currentBarWidthCoefficient
            updateCurrentBar(currentBarWidth, height: height, currentBarWidth: currentBarWidth, firstLoad: false)
            
            // areaIDを常に現在のページと同じにする
            areaID = page
            
            // ロードされたページよりも先のページにいこうとしたらその先のページを生成する
            if page > pageLoaded  {
                createMainContents(width, height: height, currentPage: page)
                pageLoaded = page
            }
            
            // カードのフェードインを許可
            cardFadeInTrigger = true
            
        }
        
    }
    
    // エリアの移動が完了したら呼ばれる
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        // スクロール数が1ページ分になったら.
        if fmod(scrollViewMain.contentOffset.x, scrollViewMain.frame.maxX) == 0 {
            
            // カードのフェードインを解く
            cardFadeInTrigger = false
            
        }
        
    }
    
    // ビューが表示される前に呼び出される
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // タブが切り替わったときのエラー解消
        scrollViewHeader.contentOffset.x = scrollViewMain.contentOffset.x/intervalPage
        
    }
    
    // モーダルへの遷移
    func showCoverVertical(tabSelected: String, selectedAreaID: Int, selectedAttractionNumber: Int) {
        let modalView = WebViewController()
        modalView.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        
        // タブナンバー
        var tabNumber: Int = 0
        if tabSelected == "Land" {
            tabNumber = 0
        } else if tabSelected == "Sea" {
            tabNumber = 1
        } else {
            tabNumber = 2
        }
        
        modalView.selectedTabNumber = tabNumber
        modalView.selectedAreaNumber = selectedAreaID
        modalView.selectedAttractionNumber = selectedAttractionNumber
        self.presentViewController(modalView, animated: true, completion: nil)
    }
    
}