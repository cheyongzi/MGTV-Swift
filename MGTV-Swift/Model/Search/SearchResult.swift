//
//  SearchResult.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2016/12/14.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import ObjectMapper

class SearchFamousInfo: MappableEx {
    
}

class SearchResultVideoItem: MappableEx {
    var name: String?
    
    override func mapping(map: Map) {
        name <- map["name"]
    }
}

class SearchResultVideo: MappableEx {
    var list: [SearchResultVideoItem]?
    
    override func mapping(map: Map) {
        list <- map["list"]
    }
}

class SearchResultItem: MappableEx {

    var playCount: String?
    var name: String?
    var image: String?
    var updateDesc: String?
    var desc: String?
    var descPrefix: String?
    var videoType: String?
    var layoutId: Int?
    var videos: [SearchResultVideo]?
    
    override func mapping(map: Map) {
        playCount <- map["playCount"]
        name <- map["name"]
        image <- map["image"]
        updateDesc <- map["updateDesc"]
        desc <- map["desc"]
        descPrefix <- map["descPrefix"]
        videoType <- map["videoType"]
        layoutId <- map["layoutId"]
        videos <- map["videos"]
    }
}

class SearchResultData: MappableEx {
    var total: Int?
    var qcorr: String?
    var famous: SearchFamousInfo?
    var hitDocs: [SearchResultItem]?
    
    override func mapping(map: Map) {
        total <- map["total"]
        qcorr <- map["qcorr"]
        famous <- map["famous"]
        hitDocs <- map["hitDocs"]
    }
}

class SearchResultResponse: BaseModel {
    var data: SearchResultData?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        data <- map["data"]
    }
}
