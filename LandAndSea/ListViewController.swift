
import UIKit
import Parse
import ParseUI
import Bolts

class ListViewController: ScrollableTabsViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
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
        
        showCoverVertical(tabSelected, selectedAreaID: areaID, selectedAttractionNumber: indexPath.row)
        
        // 選択ハイライトを解除
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    var timelineData:NSMutableArray = NSMutableArray()
    var messagesArray = [String]()
    
    // beta5からinitの前方にrequiredが必要になった
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // ロード
    func loadData() {
        
        var object = PFObject(className: "TestClass")
        object.addObject("Bananaaaaaaaa", forKey: "favoriteFood")
        object.addObject("Chocolate", forKey: "favoriteIceCream")
        object.saveInBackground()
        
        var query = PFQuery(className: "TestClass")
        query.orderByAscending("createdAt")
        
        timelineData.removeAllObjects()
        
        // call databases
        var findTimelineData:PFQuery = PFQuery(className: "TestClass")
        
        query.findObjectsInBackgroundWithBlock {
            (object, error) -> Void in
            
            for messageObject in object! {
                let messageText:String? = (messageObject as! PFObject)["favoriteFood"] as? String
                if messageText != nil {
                    self.messagesArray.append(messageText!)
                }
            }
            println(self.messagesArray)
        }
        
    }
    
}