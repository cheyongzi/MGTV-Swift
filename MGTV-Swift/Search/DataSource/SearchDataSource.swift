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
        let requestInfo = MGTVRequestInfo(path: "v6/search/autocomplete", parameters: params)
        SimpleRequestClient(requestInfo: requestInfo).send(SearchSuggestResponse.self) { (response, error) in
            complete(response, error)
        }
    }
}

struct SearchResultDataSource {
    static func fetchSearch(_ params: [String : Any], complete: @escaping CompleteBlock) {
        let requestInfo = MGTVRequestInfo(path: "v6/search/getResult", parameters: params)
        SimpleRequestClient(requestInfo: requestInfo).send(SearchResultResponse.self) { (response, error) in
            complete(response, error)
        }
    }
}
