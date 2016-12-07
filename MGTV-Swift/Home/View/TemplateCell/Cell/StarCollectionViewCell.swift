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
        }
    }

}
