
import UIKit

class CardViewController: ScrollableTabsViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    /* ------------------------ ビュー --------------------------*/
    
    // メインコンテンツを生成
    override func createMainContents(width: CGFloat, height: CGFloat, currentPage: Int) {

        areaID = currentPage
    
        // レイアウト作成
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Vertical
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 1.0
        flowLayout.itemSize = CGSizeMake(width/2, 200)
        
        // コレクションビュー作成
        collectionView = UICollectionView(frame: CGRectMake(CGFloat(areaID) * width, 0, width, height-145), collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColorFromRGB(0xF1F1F1)
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.directionalLockEnabled = false
        
        collectionView.registerNib(UINib(nibName:"attractionCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        scrollViewMain.addSubview(collectionView)
        
    }
    
    // モーダルへの遷移
    func showCoverVertical(){
        let modalView = WebViewController()
        modalView.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        modalView.selectedTabNumber = 0
        modalView.selectedAreaNumber = 0
        modalView.selectedAttractionNumber = 0
        self.presentViewController(modalView, animated: true, completion: nil)
    }
    
    /* ------------------------ セル --------------------------*/
    
    // Sectionの数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Cellの数
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return attractionName[areaID].count
    }
    
    // Cellが選択された際に呼び出される
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //println("Num: \(indexPath.row)")
        
        // Viewの移動
        //self.presentViewController(WebViewController(), animated: true, completion: nil)
        
        showCoverVertical()
        
    }
    
    // Cellの内容
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // 画面サイズの取得
        let screenSize = measureScreenSize()
        let width = screenSize.width
        let height = screenSize.height
        
        // cellを宣言
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! attractionCell
        
        // タイトル
        if var attractionTitle = cell.attractionTitle {
            
            attractionTitle.text = attractionName[areaID][indexPath.row] as? String
            
            // 行間の変更
            let lineHeight:CGFloat = 15.0
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.minimumLineHeight = lineHeight
            paragraphStyle.maximumLineHeight = lineHeight
            let attributedText = NSMutableAttributedString(string: attractionTitle.text!)
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
            attractionTitle.attributedText = attributedText
            
        }
        
        // サムネイル
        if var attractionThumbnail = cell.attractionThumbnail {
            // アトラクションイメージ
            attractionThumbnail.image = UIImage(named: "\(tabSelected)Attraction\(areaID)\(indexPath.row).jpg")
        }

        // サムネイルの背景
        if var attractionThumbnailLayer = cell.attractionThumbnailLayer {
            // 角丸
            attractionThumbnailLayer.layer.cornerRadius = 7.0
        }
        
        // 待ち時間
        if var attractionWaitingTime = cell.attractionWaitingTime {
            attractionWaitingTime.text = "\(waitingTime[areaID][indexPath.row])"
            attractionWaitingTime.textColor = UIColorFromRGB(0xEA7777)
        }
        
        // 平均待ち時間
        if var attractionAverageTime = cell.attractionAverageTime {
            attractionAverageTime.text = "（平均: \(averageTime[areaID][indexPath.row])分）"
            attractionAverageTime.textColor = UIColorFromRGB(0x888888)
            if width <= 320 {
                attractionAverageTime.font = UIFont.systemFontOfSize(8)
                attractionAverageTime.layer.position.y = 100
            }
        }
        
        // 待ち時間ステータス
        if var waitingStatus = cell.waitingStatus {
            var a: CGFloat = waitingTime[areaID][indexPath.row] as! CGFloat
            var b: CGFloat = averageTime[areaID][indexPath.row] as! CGFloat
            var waitingDifference:CGFloat = a - b
            if waitingDifference >= 30 {
                waitingStatus.text = "混んでる"
                waitingStatus.backgroundColor = UIColorFromRGB(0xE0374C)
//            } else if waitingDifference >= 30 && waitingDifference < 60 {
//                waitingStatus.text = "混んでる"
//                waitingStatus.backgroundColor = UIColorFromRGB(0xFFBE54)
            } else if waitingDifference > -30 && waitingDifference < 30 {
                waitingStatus.text = "ふつう"
                waitingStatus.backgroundColor = UIColorFromRGB(0xF4E633)
//            } else if waitingDifference <= -30 && waitingDifference > -60 {
//                waitingStatus.text = "空いてる"
//                waitingStatus.backgroundColor = UIColorFromRGB(0xB8E986)
            } else if waitingDifference <= -30 {
                waitingStatus.text = "空いてる"
                waitingStatus.backgroundColor = UIColorFromRGB(0xB8E986)
            } else {
                waitingStatus.text = "？"
            }
        }
        
        // ファストパスの時間
        if var attractionFastpassTime = cell.attractionFastpassTime {
            
            // 空だったら隠す
            if "\(fastpassTime[areaID][indexPath.row])".isEmpty {
                attractionFastpassTime.hidden = true
            }
            
            // ファストパスの帯
            if var attractionFastpassObi = cell.attractionFastpassObi {
                if "\(fastpassTime[areaID][indexPath.row])".isEmpty {
                    attractionFastpassObi.hidden = true
                }
            }
            
            // ファストパス
            attractionFastpassTime.text = "\(fastpassTime[areaID][indexPath.row])"
            
            // 角度変更
            var angle:CGFloat = CGFloat((-7 * M_PI) / 180.0)
            attractionFastpassTime.transform = CGAffineTransformMakeRotation(angle)
        }
        
        // カードのデザイン
        if var cardBack = cell.cardBack {
            
//            // 角丸
//            cardBack.layer.cornerRadius = 7.0
//            // シャドウ
//            cardBack.layer.shadowColor = UIColor.blackColor().CGColor /* 影の色 */
//            cardBack.layer.shadowOffset = CGSizeMake(0,0) /* 影の大きさ */
//            cardBack.layer.shadowOpacity = 0.4 /* 透明度 */
//            cardBack.layer.shadowRadius = 0.6 /* 影の距離 */
            
            // カードのフェードイン
            if cardFadeInTrigger == true && areaID != 0 {
                cardBack.alpha = 0
                UIView.animateWithDuration(0.5) {
                    cardBack.alpha = 1
                }
            }
        }
        
        return cell

    }
    
}