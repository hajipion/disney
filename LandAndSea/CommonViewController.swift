
import Foundation
import UIKit

class CommonViewController: UIViewController {
    
    // 画面サイズを測定
    func measureScreenSize() -> (width: CGFloat, height: CGFloat) {
        
        let width = self.view.frame.maxX, height = self.view.frame.maxY
        return (width, height)
        
    }

    // RGBカラーセット
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}