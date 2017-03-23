//
//  MGTVNetwork.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/6/23.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import ObjectMapper

let DefaultHost = "http://mobile.api.hunantv.com/"
let MobHost = "http://mob.bz.mgtv.com/"
let StHost = "http://st.bz.mgtv.com/"

struct MGTVRequestInfo {
    let host: String
    let path: String
    
    let httpMethod: HTTPMethod
    
    let parameters: Parameters?
    
    let encoding: ParameterEncoding
    
    let headers: HTTPHeaders?
    
    let enableCache: Bool
    
    init(path: String, host: String = DefaultHost, httpMethod: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, header: HTTPHeaders? = nil, enableCache: Bool = true) {
        self.host = host
        self.path = path
        self.httpMethod = httpMethod
        self.parameters = parameters
        self.encoding = encoding
        self.headers = header
        self.enableCache = enableCache
    }
}


struct SimpleRequestClient: Client, Request {
    typealias RequestInfo = MGTVRequestInfo
    
    var requestInfo: MGTVRequestInfo
    
    func send<T : Mappable>(_ dataType: T.Type, result: @escaping (T?, Error?) -> Void) {
        guard let url = URL(string: requestInfo.path, relativeTo: URL(string: requestInfo.host)) else {
            return
        }
        let request = Alamofire.request(url, method: requestInfo.httpMethod, parameters: requestInfo.parameters, encoding: requestInfo.encoding, headers: requestInfo.headers)
        guard let urlRequest = request.request else {
            return;
        }
        if let cacheResponse = URLCache.shared.cachedResponse(for: urlRequest) {
            if let json = try? JSONSerialization.jsonObject(with: cacheResponse.data, options: .allowFragments) {
                if let cacheMapper = Mapper<T>().map(JSONObject: json) {
                    result(cacheMapper, nil)
                }
            }
        }
        request.responseObject(completionHandler: { (response: DataResponse<T>) in
            if self.requestInfo.enableCache, let data = response.data ,let response = response.response {
                let urlCacheResponse = CachedURLResponse(response: response, data: data, userInfo: nil, storagePolicy: .allowed)
                URLCache.shared.storeCachedResponse(urlCacheResponse, for: urlRequest)
            }
            result(response.result.value, response.result.error)
        })
    }
}

