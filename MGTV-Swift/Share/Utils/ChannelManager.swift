//
//  ChannelManager.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/14.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit
import ObjectMapper

let channelPath = "ChannelData"
var channelData: ChannelResponse?

class ChannelManager {
    static func store(_ channelResponse: ChannelResponse) {
        let filePath = documentPath(keyPath: channelPath)
        do {
            let data = try JSONSerialization.data(withJSONObject: channelResponse.toJSON(), options: .prettyPrinted)
            try data.write(to: URL(fileURLWithPath: filePath), options: .atomic)
        } catch {
            print("channel data store error")
        }
    }
    
    static func channelList() -> ChannelResponse {
        if channelData == nil {
            var filePath = documentPath(keyPath: channelPath)
            if !FileManager.default.fileExists(atPath: filePath) {
                filePath = Bundle.main.path(forResource: "ChannelDefaultData", ofType: "json")!
            }
            do {
                let data = try Data.init(contentsOf: URL(fileURLWithPath: filePath))
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                channelData = Mapper<ChannelResponse>().map(JSONObject: json)
            } catch {
                
            }
        }
        return channelData!
    }
}

func documentPath(keyPath: String) -> String {
    let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentPath = documents.first! as String
    return documentPath.appending("/\(keyPath)")
}
