//
//  TopicTitleCell.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/13.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class TopicTitleCell: TemplateBaseTableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!

    @IBAction func buttonAction(_ sender: AnyObject) {
    }
    
    override func configResponse(responseData: TemplateResponseData?, indexPath: IndexPath?) {
        if let item = responseData?.moduleData?.first {
            
            let orignImgStr = item.phoneImgUrl
            if let path = orignImgStr {
                let pathEx = path.pathExtension()
                let imgStr = path.appending("_130x130.\(pathEx)")
                iconImageView.kf.setImage(with: URL(string: imgStr))
            } else {
                iconImageView.kf.setImage(with: URL(string: ""))
            }
            
            if item.mobileTitle != nil && item.mobileTitle! != "" {
                titleLabel.text = item.mobileTitle
            } else {
                titleLabel.text = item.name
            }
            
            descLabel.text = item.subName
        }
    }
}
