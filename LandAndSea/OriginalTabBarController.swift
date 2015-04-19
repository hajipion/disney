
import UIKit

class OriginalTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // フォント・色の変更
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName:UIFont(name:"FolkPro-Regular", size:11)!], forState:.Normal)
        UITabBar.appearance().tintColor = UIColor(red: 0.13, green: 0.55, blue: 0.83, alpha: 1.0)
        
        // アイコンの色変更
        let colorKey = UIColor(red: 234/255, green: 119/255, blue: 119/255, alpha: 1.00)
        UITabBar.appearance().tintColor = colorKey
        
        // 背景色変更
        let colorBg = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.45)
        UITabBar.appearance().barTintColor = colorBg
        
    }
    
}