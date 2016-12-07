//
//  HorizontalTemplateCell.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/13.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class HorizontalTemplateCell: TemplateBaseTableViewCell {

    @IBOutlet var baseViews: [BaseView169]!
    
    override func configResponse(responseData: TemplateResponseData?, indexPath: IndexPath?) {
        let isHideDesc = (responseData?.moduleType)! == "scrossm" ? false : true
        let datas = responseData?.moduleData ?? []
        for (index, baseView) in  baseViews.enumerated() {
            if datas.count > index {
                baseView.config(templateItem: datas[index], isDesc: isHideDesc, picSize: "366x206")
            } else {
                baseView.config(templateItem: nil, isDesc: isHideDesc, picSize: "366x206")
            }
        }
    }
}
