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
    static func fetchTemplate(params: [String : Any], complete: @escaping CompleteBlock) {
        let request = MGTVNetwork.shareInstance.request(path: "odin/c1/channel/index", parameters: params, enableCache: true, URLHost: "http://st.bz.mgtv.com/")
        request.startRequest(TemplateResponse.self) { (response, error) in
            complete(response, error)
        }
    }
    
    static func fetchChannel() {
        let request = MGTVNetwork.shareInstance.request(path: "odin/c1/channel/list", parameters: ["type" : "5", "version" : "5.0"], enableCache: true, URLHost: "http://mob.bz.mgtv.com/")
        request.startRequest(ChannelResponse.self) { (response, error) in
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
