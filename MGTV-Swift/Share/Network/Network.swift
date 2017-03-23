//
//  Network.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2017/3/21.
//  Copyright © 2017年 Che Yongzi. All rights reserved.
//

import ObjectMapper
import Alamofire

protocol Client {
    
    func send<T: Mappable>(_ dataType: T.Type, result: @escaping (T?, Error?) -> Void)
}

protocol Request {
    associatedtype RequestInfo
    var requestInfo: RequestInfo { get }
}
