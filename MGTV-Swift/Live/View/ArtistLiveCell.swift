//
//  ArtistLiveCell.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2017/1/16.
//  Copyright © 2017年 Che Yongzi. All rights reserved.
//

import UIKit

class ArtistLiveCell: TemplateBaseTableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        iconImage.layer.cornerRadius = 20
        iconImage.layer.masksToBounds = true
    }
    
    override func configResponse(responseData: TemplateResponseData?, indexPath: IndexPath?) {
        guard let item = responseData?.moduleData?.first else {
            return
        }
        iconImage.kf.setImage(with: URL.init(string: item.phoneImgUrl ?? ""))
        
        nameLabel.text = item.name
    }

}
