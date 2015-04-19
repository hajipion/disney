
import UIKit

class ShowViewController: ListViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate  {
    
    override func viewDidLoad() {
        
        super.tabSelected = "Show"
        
        super.areaName = [
            "ディズニーランド",
            "ディズニーシー"
        ]
        
        super.showName = [
            [
                "なんとかかんとか",
                "なんとーかカントーか"
            ],
            [
                "あー",
                "あー",
                "あー",
                "あー",
                "あー",
                "あー",
                "あー",
                "あー",
                "あー",
                "あー"
            ]
        ]
        
        super.showTime = [
            [
                "16:10 / 17:10",
                "18:00"
            ],
            [
                "12:00 / 13:00 / 14:00 / 15:00 / 16:00 / 17:00",
                "12:00 / 13:00 / 14:00 / 15:00 / 16:00",
                "11:00 / 12:00 / 13:00 / 14:00",
                "18:00 / 19:00 / 20:00",
                "18:00",
                "18:00",
                "18:00",
                "18:00",
                "18:00",
                "18:00"
            ]
        ]
        
        super.showArea = [
            [
                "ここ",
                "そこ"
            ],
            [
                "あああああああそこ",
                "ここ",
                "ここ",
                "ここ",
                "ここ",
                "ここ",
                "ここ",
                "ここ",
                "ここ",
                "ここ"
            ]
        ]
        
        createScrollableTabsView()
        
    }
    
}