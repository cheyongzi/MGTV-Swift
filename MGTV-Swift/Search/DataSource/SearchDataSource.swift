//
//  SearchDataSource.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2016/12/14.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import Foundation

struct SearchSuggestDataSource {
    static func fetchSuggest(_ params: [String : Any], complete: @escaping CompleteBlock) {
        let request = MGTVNetwork.shareInstance.request(path: "v6/search/autocomplete", parameters: params)
        request.startRequest(SearchSuggestResponse.self){ (response, error) in
            complete(response, error)
        }
    }
}

struct SearchResultDataSource {
    static func fetchSearch(_ params: [String : Any], complete: @escaping CompleteBlock) {
        let request = MGTVNetwork.shareInstance.request(path: "v6/search/getResult", parameters: params)
        request.startRequest(SearchResultResponse.self){ (response, error) in
            complete(response, error)
        }
    }
}
