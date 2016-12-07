//
//  CircleCollectionViewCell.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2016/12/5.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class CircleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        iconImageView.layer.cornerRadius = 33
        iconImageView.layer.masksToBounds = true
    }

    var templateItem: TemplateResponseItem? {
        didSet {
            guard let item = templateItem else {
                return
            }
            
            if let imageUrl = item.phoneImgUrl {
                let pathEx = imageUrl.pathExtension()
                let imgStr = imageUrl.appending("_\("130x130").\(pathEx)")
                iconImageView.kf.setImage(with: URL(string: imgStr))
            }
            
            titleLabel.text = isEmpty(data: item.mobileTitle) ? item.name : item.mobileTitle
        }
    }
}
