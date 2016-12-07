//
//  RecommondResponse.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2016/12/7.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import ObjectMapper

class RecommonResponseData: MappableEx {
    var type: Int?
    var videoId: Int?
    var clipId: Int?
    var plid: Int?
    var videoIndex: Int?
    var name: String?
    var title: String?
    var image: String?
    var desc: String?
    var plcount: Int?
    var info: String?
    var rcType: Int?
    
    override func mapping(map: Map) {
        type <- map["type"]
        videoId <- map["videoId"]
        clipId <- map["clipId"]
        plid <- map["plid"]
        videoIndex <- map["videoIndex"]
        name <- map["name"]
        title <- map["title"]
        image <- map["image"]
        desc <- map["desc"]
        plcount <- map["plcount"]
        info <- map["info"]
        rcType <- map["rcType"]
    }
}

class RecommondResponse: BaseModel {
    var data: [RecommonResponseData]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        data <- map["data"]
    }
}
