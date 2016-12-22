//
//  RecommondDataSource.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2016/12/7.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import Foundation

struct RecommondDataSource {
    static func fetchGuess(_ params: [String : Any], complete: @escaping CompleteBlock) {
        guard let templateData = params["template"] as? TemplateResponseData else {
            return
        }
        let request = MGTVNetwork.shareInstance.request(path: "mobile/user",parameters: ["channelId" : TemplateDataManager.dataManager.currentChannelId], URLHost: "http://rc.mgtv.com/")
        request.startRequest(RecommondResponse.self) { (response, error) in
            guard !(error != nil), let guessResponse = response else {
                templateData.redirectStatus = 3
                complete(nil, error)
                return
            }
            
            templateData.guessData = guessResponse
            templateData.redirectStatus = 2
            complete(templateData, nil)
        }
    }
    
    static func fetchRank(_ params: [String : Any], complete: @escaping CompleteBlock) {
        guard let templateData = params["template"] as? TemplateResponseData else {
            return
        }
        let request = MGTVNetwork.shareInstance.request(path: "mobile/rank",parameters: ["channelId" : TemplateDataManager.dataManager.currentChannelId], URLHost: "http://rc.mgtv.com/")
        request.startRequest(RecommondResponse.self) { (response, error) in
            guard !(error != nil), let rankResponse = response else {
                templateData.redirectStatus = 3
                complete(nil, error)
                return
            }
            
            templateData.rankData = rankResponse
            templateData.redirectStatus = 2
            complete(templateData, nil)
        }
    }
}
