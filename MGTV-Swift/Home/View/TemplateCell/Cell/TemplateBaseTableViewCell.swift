//
//  TemplateBaseTableViewCell.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/11.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

protocol TemplateTableCellConfig {
    func configResponse(responseData: TemplateResponseData?, indexPath: IndexPath?)
}

class TemplateBaseTableViewCell: UITableViewCell, TemplateTableCellConfig {
    func configResponse(responseData: TemplateResponseData?, indexPath: IndexPath?) {
        
    }
}
