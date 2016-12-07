//
//  MoreLinkCell.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/13.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class MoreLinkCell: TemplateBaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func buttonAction(_ sender: AnyObject) {
    }
    
    override func configResponse(responseData: TemplateResponseData?, indexPath: IndexPath?) {
        if let item = responseData?.moduleData?.first {
            if item.mobileTitle != nil && item.mobileTitle! != "" {
                titleLabel.text = item.mobileTitle
            } else {
                titleLabel.text = item.name
            }
        }
    }

}
