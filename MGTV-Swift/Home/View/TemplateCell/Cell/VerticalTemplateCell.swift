//
//  VerticalTemplateCell.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/13.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class VerticalTemplateCell: TemplateBaseTableViewCell {

    
    @IBOutlet var baseViews: [BaseView57]!
    
    override func configResponse(responseData: TemplateResponseData?, indexPath: IndexPath?) {
        let isHideDesc = (responseData?.moduleType)! == "hypsog" ? false : true
        let datas = responseData?.moduleData ?? []
        for (index, baseView) in  baseViews.enumerated() {
            if datas.count > index {
                baseView.config(templateItem: datas[index], isDesc: isHideDesc, picSize: "242x344")
            } else {
                baseView.config(templateItem: nil, isDesc: isHideDesc, picSize: "242x344")
            }
        }
    }
}
