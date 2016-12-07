//
//  TemplateCollectionViewCell.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/10.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class TemplateCollectionViewCell: UICollectionViewCell {
    
    //MARK: - TableViewSource
    lazy var tableViewSource: TemplateTableViewSource = {
        let tableViewSource = TemplateTableViewSource.init(frame: self.bounds)
        return tableViewSource
    }()
    //MARK: - Init method
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.addSubview(self.tableViewSource.tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Config data
    func configCell(response: TemplateResponse?) {
        var datas: [TemplateResponseData] = []
        if let templateData = response {
            datas = templateData.data!
        }
        self.tableViewSource.dataArray = datas
    }
}
