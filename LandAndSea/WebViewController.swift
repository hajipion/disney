
import UIKit
import WebKit

class WebViewController: CommonViewController, UIWebViewDelegate {
    
    // ウェブビュー
    var _webkitview: WKWebView?
    
    // 閉じるボタン
    let closeButton: UIButton = UIButton.self(frame: CGRectZero)
    
    // 選択されたナンバー
    var selectedTabNumber: Int = 0
    var selectedAreaNumber: Int = 0
    var selectedAttractionNumber: Int = 0
    
    // URL格納
    var urlArray: NSArray = [
        [
            [
                "http://www.apple.com",
                "http://www.apple.com",
                "http://www.google.com"
            ],
            [
                "http://www.apple.com",
                "http://www.apple.com",
                "http://www.apple.com"
            ],
            [
                ""
            ],
            [
                ""
            ],
            [
                ""
            ],
            [
                ""
            ],
            [
                ""
            ]
        ],
        [
            [
                "http://www.apple.com",
                "http://www.apple.com",
                "http://www.apple.com"
            ],
            [
                ""
            ],
            [
                ""
            ],
            [
                ""
            ],
            [
                ""
            ],
            [
                ""
            ],
            [
                ""
            ]
        ],
        [
            [
                "http://www.apple.com",
                "http://www.apple.com",
                "http://www.apple.com"
            ],
            [
                "http://www.apple.com",
                "http://www.apple.com",
            ]
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // WebKitのインスタンス作成
        self._webkitview = WKWebView()
        
        // 画面サイズの取得
        let screenSize = measureScreenSize()
        let width = screenSize.width
        let height = screenSize.height
        
        // ボタンの追加
        closeButton.frame = CGRectMake(0, height-60, width, 60)
        closeButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        closeButton.setTitle("×", forState: UIControlState.Normal)
        closeButton.titleLabel!.font = UIFont(name: "FolkPro-Regular", size: 20)
        closeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        closeButton.addTarget(self, action: "closeMe:", forControlEvents: .TouchUpInside)
        
        // 閉じるボタンの追加
        self._webkitview?.addSubview(closeButton)
        
        
        // WebKitをviewに紐付け
        self.view = self._webkitview!
        
        // URL生成
        var urlString: String! = urlArray[selectedTabNumber][selectedAreaNumber][selectedAttractionNumber] as! String
        var url = NSURL(string:urlString)
        var req = NSURLRequest(URL:url!)
        self._webkitview!.loadRequest(req)
        
        // インジケータを表示する
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        // スワイプで戻ったり進んだり
        self._webkitview!.allowsBackForwardNavigationGestures = true
        
        
    }
    
    // 閉じる挙動
    func closeMe(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Pageがすべて読み込み終わった時呼ばれる
    func webViewDidFinishLoad(webView: UIWebView) {
        closeButton.alpha = 0.6
    }
    
    // ステータスバーを消す
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
