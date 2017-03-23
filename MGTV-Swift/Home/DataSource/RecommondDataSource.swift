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
        let requestInfo = MGTVRequestInfo(path: "mobile/user", host: "http://rc.mgtv.com/", parameters: ["channelId" : TemplateDataManager.dataManager.currentChannelId])
        SimpleRequestClient(requestInfo: requestInfo).send(RecommondResponse.self) { (response, error) in
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
        let requestInfo = MGTVRequestInfo(path: "mobile/rank", host: "http://rc.mgtv.com/", parameters: ["channelId" : TemplateDataManager.dataManager.currentChannelId])
        SimpleRequestClient(requestInfo: requestInfo).send(RecommondResponse.self) { (response, error) in
            guard !(error != nil), let guessResponse = response else {
                templateData.redirectStatus = 3
                complete(nil, error)
                return
            }
            
            templateData.rankData = guessResponse
            templateData.redirectStatus = 2
            complete(templateData, nil)
        }
    }
}
