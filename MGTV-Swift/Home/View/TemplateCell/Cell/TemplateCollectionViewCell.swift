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
    let homeTableViewModel: HomeTableViewModel = HomeTableViewModel([])
    
    //MARK: - Init method
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        homeTableViewModel.tableView.frame = self.bounds
        
        self.addSubview(homeTableViewModel.tableView)
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
        homeTableViewModel.datas = [datas]
        homeTableViewModel.tableView.reloadData()
    }
    
    func storeOffset() {
        TemplateDataManager.dataManager.storeOffset(homeTableViewModel.tableView.contentOffset.y, channelId: TemplateDataManager.dataManager.currentChannelId)
    }
    
    func setOffset(_ channelId: String) {
        homeTableViewModel.tableView.setContentOffset(CGPoint(x: 0, y: TemplateDataManager.dataManager.offset(channelId)), animated: false)
    }
}
