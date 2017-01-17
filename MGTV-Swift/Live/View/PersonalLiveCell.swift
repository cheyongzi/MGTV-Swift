//
//  PersonalLiveCell.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2017/1/17.
//  Copyright © 2017年 Che Yongzi. All rights reserved.
//

import UIKit

class PersonalLiveCell: TemplateBaseTableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var bottomLabel: UILabel!
    
    override func awakeFromNib() {
        iconImage.layer.cornerRadius = 15
        iconImage.layer.masksToBounds = true
    }
    
    override func configResponse(responseData: TemplateResponseData?, indexPath: IndexPath?) {
        guard let item = responseData?.moduleData?[0] else {
            return
        }
        
        iconImage.kf.setImage(with: URL.init(string: item.imgHVUrl ?? ""))
        
        mainImage.kf.setImage(with: URL.init(string: item.imgHUrl ?? ""))
        
        nameLabel.text = item.name
        descLabel.text = item.mobileTitle
        bottomLabel.text = item.subName
    }
}
