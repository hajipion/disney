
import UIKit

class ShowTableViewController: ScrollableTabsViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    /* ------------------------ ビュー --------------------------*/
    
    // メインコンテンツを生成
    override func createMainContents(width: CGFloat, height: CGFloat, currentPage: Int) {
        
        areaID = currentPage
        
        listTableView = UITableView(frame: CGRect(x: CGFloat(areaID) * width, y: 0, width: width, height: height-145))
        
        listTableView.rowHeight = UITableViewAutomaticDimension
        
        listTableView.separatorColor = UIColor.clearColor()
        listTableView.backgroundColor = UIColorFromRGB(0xF1F1F1)
        
        listTableView.delegate = self
        listTableView.dataSource = self

        var nib:UINib = UINib(nibName: "listCell", bundle: nil)
        listTableView.registerNib(nib, forCellReuseIdentifier: "cell")
        
        self.scrollViewMain.addSubview(listTableView)
        
    }
    
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
        
        createCardView()
        
    }

    /* ------------------------ セル --------------------------*/

    // セクションの数
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return self.showName.count
//    }
    
    // セルの行数
    func tableView(listTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return showName[areaID].count
        
    }
    
    
    // セルの内容を変更
    func tableView(listTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 再利用でセル宣言
        let cell:listTableViewCell = (self.listTableView.dequeueReusableCellWithIdentifier("cell") as? listTableViewCell)!
        
        // 画面サイズの取得
        let screenSize = measureScreenSize()
        let width = screenSize.width
        
        // セルの背景
        cell.backgroundColor = UIColorFromRGB(0xF1F1F1)
        
        // 角丸
        cell.listBack.layer.cornerRadius = 2.0
        
        // 枠線（シャドウライク）
        cell.listBack.layer.borderWidth = 1
        cell.listBack.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).CGColor
        
        // ショーの名前
        cell.showName.text = "\(showName[areaID][indexPath.row])"
        
        // ショーの時間
        cell.showTime.text = "\(showTime[areaID][indexPath.row])"
        
        // ショーの時間のフォントサイズ
        var countText: CGFloat = CGFloat(count(showTime[areaID][indexPath.row] as! String))
        println(countText)
        if width > 410 {
            if countText > 35 {
                cell.showTime.font = UIFont.systemFontOfSize(13)
            } else {
                cell.showTime.font = UIFont.systemFontOfSize(17)
            }
        } else if width > 370 {
            if countText > 35 {
                cell.showTime.font = UIFont.systemFontOfSize(12)
            } else if countText > 27 {
                cell.showTime.font = UIFont.systemFontOfSize(16)
            } else {
                cell.showTime.font = UIFont.systemFontOfSize(17)
            }
        } else if width <= 370 {
            if countText > 27 {
                cell.showTime.font = UIFont.systemFontOfSize(10)
            } else if countText > 20 {
                cell.showTime.font = UIFont.systemFontOfSize(15)
            } else {
                cell.showTime.font = UIFont.systemFontOfSize(17)
            }
        }
        
        // ショーの場所
        cell.showArea.text = "\(showArea[areaID][indexPath.row])"
        
        // ショーのサムネイル
        cell.showThumbnail.image = UIImage(named: "Show\(areaID)\(indexPath.row).jpg")
        
        // カードのフェードイン
        if cardFadeInTrigger == true && areaID != 0 {
            cell.listBack.alpha = 0
            UIView.animateWithDuration(0.5) {
                cell.listBack.alpha = 1
            }
        }
        
        // 選択された時の背景色
        var cellSelectedBgView = UIView()
        cellSelectedBgView.backgroundColor = UIColorFromRGB(0xF1F1F1)
        cell.selectedBackgroundView = cellSelectedBgView
        
        // 最後にセルを返す！
        return cell
        
    }
    
    // セルの高さ
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        // if (count(String(articles[indexPath.row] as! NSString)) > 30) {
        //    return 215
        //} else {
        //    return 95
        //}
        
        return 96
            
    }
    
    
    // Cell が選択された場合
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
    }
    
}