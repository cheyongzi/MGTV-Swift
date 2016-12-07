//
//  TemplateResponse.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/13.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import ObjectMapper

class TemplateResponseItem: MappableEx {
    
    var childId: String?
    var connectUrl: String?
    var cornerType: String?
    var filter: String?
    var imgHUrl: String?
    var imgHUrlToMobile: String?
    var imgHVUrl: String?
    var isShare: String?
    var jumpId: String?
    var jumpKind: String?
    var liveEndTime: String?
    var liveStartTime: String?
    var mobileTitle: String?
    var name: String?
    var pageUrl: String?
    var phoneImgUrl: String?
    var playerType: String?
    var rightCorner: String?
    var sortNo: String?
    var subName: String?
    var tvChannelId: String?
    var updateInfo: String?
    
    override func mapping(map: Map) {
        childId <- map["childId"]
        connectUrl <- map["connectUrl"]
        cornerType <- map["cornerType"]
        filter <- map["filter"]
        imgHUrl <- map["imgHUrl"]
        imgHUrlToMobile <- map["imgHUrlToMobile"]
        imgHVUrl <- map["imgHVUrl"]
        isShare <- map["isShare"]
        jumpId <- map["jumpId"]
        jumpKind <- map["jumpKind"]
        liveEndTime <- map["liveEndTime"]
        liveStartTime <- map["liveStartTime"]
        mobileTitle <- map["mobileTitle"]
        name <- map["name"]
        pageUrl <- map["pageUrl"]
        phoneImgUrl <- map["phoneImgUrl"]
        playerType <- map["playerType"]
        rightCorner <- map["rightCorner"]
        sortNo <- map["sortNo"]
        subName <- map["subName"]
        tvChannelId <- map["tvChannelId"]
        updateInfo <- map["updateInfo"]
    }
}

class TemplateResponseData: MappableEx {
    var adId: Int?
    var combineId: String?
    var dataModuleId: Int?
    var isExchange: String?
    var moduleId: Int?
    var moduleName: String?
    var moduleTitle: String?
    var moduleType: String?
    var moduleData: [TemplateResponseItem]?
    /// 下面的属性属于自定义属性，用于二次请求
    var starData: StarResponse?
    var guessData: RecommondResponse?
    var rankData: RecommondResponse?
    var redirectStatus: Int = 0
    
    override func mapping(map: Map) {
        adId <- map["adId"]
        combineId <- map["combineId"]
        dataModuleId <- map["dataModuleId"]
        isExchange <- map["isExchange"]
        moduleId <- map["moduleId"]
        moduleName <- map["moduleName"]
        moduleTitle <- map["moduleTitle"]
        moduleType <- map["moduleType"]
        moduleData <- map["moduleData"]
    }
}

class ChannelInfo: MappableEx {
    var channelIcon: String?
    var fstlvlId: String?
    var pageType: String?
    var title: String?
    var wechatDesc: String?
    var wechatTitle: String?
    var vclassId: String?
    
    override func mapping(map: Map) {
        channelIcon <- map["channelIcon"]
        fstlvlId <- map["fstlvlId"]
        pageType <- map["pageType"]
        title <- map["title"]
        wechatDesc <- map["wechatDesc"]
        wechatTitle <- map["wechatTitle"]
        vclassId <- map["vclassId"]
    }
}

class TemplateResponse: BaseModel {

    var data: [TemplateResponseData]?
    var channel: ChannelInfo?
    var lastRequestTime: Date?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        data <- map["data"]
        channel <- map["channel"]
    }
}
