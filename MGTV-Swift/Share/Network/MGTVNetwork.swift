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

private var key: Void?
extension DataRequest {
    func startRequest<T : Mappable>(_ dataType: T.Type?, resultClosure: @escaping (_ resultData: T?, _ error: Error?) -> Void) {
        if self.enableCache {
            self.responseJSON(completionHandler: { (response) in
                guard let request = self.request else {
                    resultClosure(nil, response.result.error)
                    return
                }
                
                guard let data = response.data else {
                    resultClosure(nil, response.result.error)
                    return
                }
                var responsedData: Data?
                if response.result.error != nil {
                    let cacheResponse = URLCache.shared.cachedResponse(for: request)
                    responsedData = cacheResponse?.data
                } else {
                    let urlCacheResponse = CachedURLResponse(response: response.response!, data: data, userInfo: nil, storagePolicy: .allowed)
                    URLCache.shared.storeCachedResponse(urlCacheResponse, for: request)
                    responsedData = data
                }
                
                if responsedData == nil {
                    resultClosure(nil, response.result.error)
                } else {
                    var json: Any?
                    do {
                        json = try JSONSerialization.jsonObject(with: responsedData!, options: .allowFragments)
                    }catch {
                        print("json parse error")
                    }
                    let resultValue = Mapper<T>().map(JSONObject: json)
                    resultClosure(resultValue, response.result.error)
                }
            })
        } else {
            self.responseObject { (response: DataResponse<T>) in
                resultClosure(response.result.value, response.result.error)
            }
        }
    }
    
    var enableCache: Bool {
        set {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &key) as! Bool
        }
    }
}

class MGTVNetwork {
    static let shareInstance = MGTVNetwork()
    
    private init () { }
    
    func request(path: String, method: Alamofire.HTTPMethod = .get, parameters: [String : Any]? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: [String: String]? = nil, enableCache : Bool = false, URLHost : String? = nil) -> Alamofire.DataRequest {
        let host = URLHost ?? "http://mobile.api.hunantv.com/"
        let request = Alamofire.request("\(host)\(path)", method: method, parameters: parameters, encoding: encoding, headers: headers);
        request.enableCache = enableCache
        return request
    }
}

