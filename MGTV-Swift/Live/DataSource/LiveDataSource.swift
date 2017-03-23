//
//  LiveDataSource.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2017/1/16.
//  Copyright © 2017年 Che Yongzi. All rights reserved.
//

import Foundation

struct LiveDataSource {
    static func fetchLive(params: [String : Any]?, complete: @escaping CompleteBlock) {
        let requestInfo = MGTVRequestInfo(path: "channel/live", parameters: params)
        SimpleRequestClient(requestInfo: requestInfo).send(TemplateResponse.self) { (response, error) in
            complete(response, error)
        }
    }
}
