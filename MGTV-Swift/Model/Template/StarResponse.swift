//
//  StarResponse.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2016/12/6.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import ObjectMapper

class StarDataInfo: MappableEx {
    var uid: String?
    var onlineCount: String?
    var photo: String?
    var online: String?
    var nickName: String?
    var hotValue: String?
    var ranking: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        uid <- map["uid"]
        onlineCount <- map["onlineCount"]
        photo <- map["photo"]
        online <- map["online"]
        nickName <- map["nickName"]
        hotValue <- map["hotValue"]
        ranking <- map["ranking"]
        
    }
}

class StarData: MappableEx {
    var users: [StarDataInfo]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        users <- map["users"]
    }
}

class StarResponse: BaseModel {
    var data: StarData?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        data <- map["data"]
    }
}
