//
//  BaseModel.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/13.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import ObjectMapper

class BaseModel: Mappable {

    var code: Int?
    var msg: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        msg <- map["msg"]
    }
}

class MappableEx: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
}
