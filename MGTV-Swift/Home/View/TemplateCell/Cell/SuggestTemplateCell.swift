//
//  SuggestTemplateCell.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2016/12/7.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class SuggestTemplateCell: TemplateBaseTableViewCell {

    @IBOutlet var baseViews: [BaseView169]!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func configResponse(responseData: TemplateResponseData?, indexPath: IndexPath?) {
        guard let templateData = responseData else {
            return
        }
        let redirectValue = templateData.redirectStatus
        
        if redirectValue == 0 {
            RecommondDataSource.fetchGuess(["template" : templateData]){ [unowned self] (guessResponse, error) in
                
                guard let templateResponse = guessResponse as? TemplateResponseData else {
                    return
                }
                self.configResponse(responseData: templateResponse, indexPath: indexPath)
            }
        }
        
        guard let guessData = templateData.guessData else {
            return
        }
        
        var isHideDesc = true
        if templateData.moduleType == "sugg2" {
            isHideDesc = false
        }
        
        for (index, baseView) in baseViews.enumerated() {
            baseView.config(recommondItem: guessData.data?[index], isDesc: isHideDesc, picSize: "366x206")
        }
    }
    
}
