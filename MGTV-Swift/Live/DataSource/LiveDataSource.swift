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
        let request = MGTVNetwork.shareInstance.request(path: "channel/live", parameters: params, enableCache: true)
        request.startRequest(TemplateResponse.self) { (response, error) in
            complete(response, error)
        }
    }
}
