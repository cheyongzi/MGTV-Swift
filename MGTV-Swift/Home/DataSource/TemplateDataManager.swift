//
//  TemplateDataManager.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/14.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class TemplateDataManager {
    static let dataManager = TemplateDataManager()
    private init() {}
    /// 频道数据
    private var channels: [ChannelResponseData] = ChannelManager.channelList().data ?? []
    /// 每个频道对应的首页数据
    var templates: [String : TemplateResponse] = [:]
    /// 每个频道对应的滑动位置
    var offsets: [String : CGFloat] = [:]
    /// 当前展示的频道ID
    var currentChannelId: String = ""
    /// 获取本地管理的频道列表数据
    ///
    /// - returns: Array ChannelResponseData
    func channelDatas() -> [ChannelResponseData] {
        return channels
    }
    
    //MARK: - 所有频道的数据
    
    /// 获取本地管理的频道数据
    ///
    /// - returns: Dictionary key为频道id  value为频道的数据
    func templateDatas() -> [String : TemplateResponse]? {
        return templates
    }
    
    //MARK: - 频道滑动位置
    
    /// 获取本地管理的各频道滑动的位置
    ///
    /// - returns: Dictionary key为频道id  value为频道滑动的位置
    func templateOffsets() -> [String : CGFloat]? {
        return offsets
    }
    
    //MARK: - 查询片库id
    
    /// 根据频道id查找片库id
    ///
    /// - parameter channelId: 频道id
    ///
    /// - returns: String  片库id
    func libId(channelId: String) -> String {
        var currentLibId = ""
        for channel in channels {
            if channelId == channel.vclassId {
                currentLibId = channel.fstlvlId ?? ""
                break
            }
        }
        return currentLibId
    }
    
    //MARK: - 根据频道id获取频道首页数据
    func template(channelId: String) -> TemplateResponse?{
        return templates[channelId]
    }
    
    //MARK: - 根据频道id和频道首页数据存储
    func storeResponse(_ response: TemplateResponse, channelId: String) {
        templates[channelId] = response
    }
    
    //MARK: - 根据频道id和页面滚动位置存储数据
    func storeOffset(_ offset: CGFloat, channelId: String) {
        offsets[channelId] = offset
    }
    
    //MARK: - 根据频道id定位频道位置
    func index(_ channelId: String) -> Int {
        var index = -1
        for (channelIndex, channel) in channels.enumerated() {
            if channel.vclassId == channelId {
                index = channelIndex
                break
            }
        }
        return index
    }
    
    //MARK: - 根据频道id返回频道滚动位置
    func offset(_ channelId: String) -> CGFloat {
        return offsets[channelId] ?? 0
    }
}
