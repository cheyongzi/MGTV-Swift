//
//  StarCollectionViewCell.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2016/12/6.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class StarCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var liveStatusImage: UIImageView!
    @IBOutlet weak var onLineNumBackImg: UIImageView!
    @IBOutlet weak var onLineNumLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        iconImageView.layer.cornerRadius = 33
        iconImageView.layer.masksToBounds = true
    }
    
    var starInfo: StarDataInfo? {
        didSet {
            guard let info = starInfo else {
                return
            }
            
            if let photo = info.photo {
                iconImageView.kf.setImage(with: URL(string: photo))
            }
            
            titleLabel.text = info.nickName
            
            if info.online == "offline" {
                liveStatusImage.isHidden = true
                onLineNumBackImg.image = UIImage(named: "Star_Follow_Quantity")
                onLineNumLabel.text = info.hotValue
            } else {
                liveStatusImage.isHidden = false
                onLineNumBackImg.image = UIImage(named: "Star_Live_Quantity")
                onLineNumLabel.text = info.onlineCount
            }
        }
    }

}
