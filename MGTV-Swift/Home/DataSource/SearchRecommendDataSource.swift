//
//  SearchRecommendDataSource.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2016/12/12.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import Foundation

struct SearchRecommendDataSource {
    static func fetchSearchRecommend(_ params: [String : Any]?, complete: @escaping CompleteBlock) {
        let request = MGTVNetwork.shareInstance.request(path: "v6/search/recommend", parameters: params)
        request.startRequest(SearchRecommendResponse.self){ (response, error) in
            complete(response, error)
        }
    }
}
