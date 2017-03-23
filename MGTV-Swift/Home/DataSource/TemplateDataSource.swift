//
//  TemplateDataSource.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/10.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import Alamofire

typealias CompleteBlock = (AnyObject?, Error?) -> Void

struct TemplateDataSource {
    static func fetchTemplate(_ params: [String : Any], complete: @escaping CompleteBlock) {
        let requestInfo = MGTVRequestInfo(path: "odin/c1/channel/index", host: "http://st.bz.mgtv.com/", parameters: params)
        SimpleRequestClient(requestInfo: requestInfo).send(TemplateResponse.self) { (response, error) in
            complete(response, error)
        }
    }
    
    static func fetchChannel() {
        let requestInfo = MGTVRequestInfo(path: "odin/c1/channel/list", host: "http://mob.bz.mgtv.com/", parameters: ["type" : "5", "version" : "5.0"])
        SimpleRequestClient(requestInfo: requestInfo).send(ChannelResponse.self) { (response, error) in
            guard error == nil else {
                return
            }
            guard let channelResponse = response else {
                return
            }
            guard let datas = channelResponse.data else {
                return
            }
            guard datas.count > 0 else {
                return
            }
            ChannelManager.store(channelResponse)
        }
    }
}
