//
//  SearchSuggest.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2016/12/14.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import ObjectMapper

class SearchSuggestItem: MappableEx {
    var videoType: String?
    var descStr: String?
    var image: String?
    var videoId: Int?
    var name: String?
    var type: String?
    
    override func mapping(map: Map) {
        videoType <- map["videoType"]
        descStr <- map["descStr"]
        image <- map["image"]
        videoId <- map["videoId"]
        name <- map["name"]
        type <- map["type"]
    }
}

class SearchSuggestResponse: BaseModel {
    var data: [SearchSuggestItem]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
    
}
