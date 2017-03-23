//
//  RankVerticalCell.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2016/12/7.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class RankVerticalCell: TemplateBaseTableViewCell {
    
    
    @IBOutlet var baseViews: [BaseView57]!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func configResponse(responseData: TemplateResponseData?, indexPath: IndexPath?) {
        guard let templateData = responseData else {
            return
        }
        let redirectValue = templateData.redirectStatus
        if redirectValue == 0 {
            RecommondDataSource.fetchRank(["template" : templateData]){ [unowned self] (rankResponse, error) in
                
                guard let templateResponse = rankResponse as? TemplateResponseData else {
                    return
                }
                self.configResponse(responseData: templateResponse, indexPath: indexPath)
            }
        }
        
        guard let rankData = templateData.rankData else {
            return
        }
        
        var isHideDesc = true
        if templateData.moduleType == "rank2" {
            isHideDesc = false
        }
        
        for (index, baseView) in baseViews.enumerated() {
            baseView.config(recommondItem: rankData.data?[index], isDesc: isHideDesc, picSize: "366x206")
        }
    }
    
}
