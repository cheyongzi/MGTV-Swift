//
//  SearchRecommend.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2016/12/12.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import ObjectMapper

class SearchRecommendItem: MappableEx {
    var rank: Int?
    var name: String?
    
    override func mapping(map: Map) {
        rank <- map["rank"]
        name <- map["name"]
    }
}

class SearchRecommendResponse: BaseModel {
    var data: [SearchRecommendItem]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        data <- map["data"]
    }
}
