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
        let request = MGTVNetwork.shareInstance.request(path: "artist/getArtistListOrderByRankList", enableCache: true, URLHost: "http://open.artist.api.max.mgtv.com/")
        request.startRequest(StarResponse.self) { (response, error) in
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
