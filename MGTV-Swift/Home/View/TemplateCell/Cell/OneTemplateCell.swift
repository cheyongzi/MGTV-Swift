//
//  OneTemplateCell.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/13.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class OneTemplateCell: TemplateBaseTableViewCell {

    @IBOutlet weak var baseView: BaseView169!
    
    override func configResponse(responseData: TemplateResponseData?, indexPath: IndexPath?) {
        var isHideDesc = true
        if let moduleType = responseData?.moduleType {
            if moduleType == "bcrossm" || moduleType == "king" {
                isHideDesc = false
            }
        }
        let datas = responseData?.moduleData ?? []
        baseView.config(templateItem: datas.first, isDesc: isHideDesc, picSize: "738x416")
    }

}
