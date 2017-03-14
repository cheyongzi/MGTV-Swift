//
//  BaseView169.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/13.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit
import Kingfisher

class BaseView169: BaseView {
    
    //MARK: - config cell method
    override func config(templateItem item: TemplateResponseItem?, isDesc: Bool, picSize: String) {
        super.config(templateItem: item, isDesc: isDesc, picSize: picSize)
        
        baseImageView.configTemplate(item: item, picSize: picSize)
    }

}
