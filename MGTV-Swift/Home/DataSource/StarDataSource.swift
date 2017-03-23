//
//  StarDataSource.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2016/12/6.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import Foundation

struct StarDataSource {
    static func fetchStars(params: [String : Any], complete: @escaping CompleteBlock) {
        guard let templateData = params["template"] as? TemplateResponseData else {
            return
        }
        let requestInfo = MGTVRequestInfo(path: "artist/getArtistListOrderByRankList", host: "http://open.artist.api.max.mgtv.com/")
        SimpleRequestClient(requestInfo: requestInfo).send(StarResponse.self) { (response, error) in
            guard !(error != nil), let starResponse = response else {
                templateData.redirectStatus = 3
                complete(nil, error)
                return
            }
            
            templateData.starData = starResponse
            templateData.redirectStatus = 2
            complete(templateData, nil)
        }
    }
}
