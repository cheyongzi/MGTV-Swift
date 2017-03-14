//
//  SectionTitleCell.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/13.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class SectionTitleCell: TemplateBaseTableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var clickMoreImage: UIImageView!
    @IBOutlet weak var refreshButton: UIButton!
    @IBAction func buttonAction(_ sender: AnyObject) {
        
    }
    
    override func configResponse(responseData: TemplateResponseData?, indexPath: IndexPath?) {
        if let item = responseData?.moduleData?.first {
            if item.mobileTitle != nil && item.mobileTitle! != "" {
                titleLabel.text = item.mobileTitle
            } else {
                titleLabel.text = item.name
            }
            
            if let exchange = responseData?.isExchange, Int(exchange) == 1 {
                refreshButton.isHidden = false
            } else {
                refreshButton.isHidden = true
            }
            
            if let jumpKind = item.jumpKind, !jumpKind.isEmpty, Int(jumpKind) != 0 {
                clickMoreImage.isHidden = false
            } else {
                clickMoreImage.isHidden = true
            }
        }
    }
}
