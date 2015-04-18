//
//  attractionCell.swift
//  controller
//
//  Created by 広野　萌 on 2015/04/08.
//  Copyright (c) 2015年 hhirono. All rights reserved.
//

import UIKit

class attractionCell: UICollectionViewCell {
    
    @IBOutlet var attractionTitle:UILabel!
    @IBOutlet var attractionThumbnail:UIImageView!
    @IBOutlet var cardBack:UIView!
    @IBOutlet var attractionThumbnailLayer:UIView!
    
    @IBOutlet var attractionWaitingTime:UILabel!
    @IBOutlet var attractionAverageTime:UILabel!
    @IBOutlet var waitingStatus: UILabel!
    
    @IBOutlet var attractionFastpassObi:UIView!
    @IBOutlet var attractionFastpassTime:UILabel!
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
}
