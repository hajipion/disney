//
//  listCell.swift
//  controller
//
//  Created by 広野　萌 on 2015/04/08.
//  Copyright (c) 2015年 hhirono. All rights reserved.
//

import UIKit

class listTableViewCell: UITableViewCell {
    
    @IBOutlet weak var listBack: UIView!
    @IBOutlet weak var showName: UILabel!
    @IBOutlet weak var showTime: UILabel!
    @IBOutlet weak var showArea: UILabel!
    @IBOutlet weak var showThumbnail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
