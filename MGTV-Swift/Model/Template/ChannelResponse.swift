//
//  ChannelResponse.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/14.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import ObjectMapper

class ChannelResponseData: MappableEx {
    
    var channelIcon: String?
    var description: String?
    var fstlvlId: String?
    var keywords: String?
    var library: String?
    var pageType: String?
    var title: String?
    var vclassId: String?
    var vclassName: String?
    var vclassType: String?
    var wechatDesc: String?
    var wechatTitle: String?
    var channelId: String?
    
    override func mapping(map: Map) {
        channelIcon <- map["channelIcon"]
        description <- map["description"]
        fstlvlId <- map["fstlvlId"]
        keywords <- map["keywords"]
        library <- map["library"]
        pageType <- map["pageType"]
        title <- map["title"]
        vclassId <- map["vclassId"]
        vclassName <- map["vclassName"]
        vclassType <- map["vclassType"]
        wechatDesc <- map["wechatDesc"]
        wechatTitle <- map["wechatTitle"]
        channelId <- map["channelId"]
    }
}

class ChannelResponse: BaseModel {

    var data: [ChannelResponseData]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        data <- map["data"]
    }
}
