//
//  UserCenterViewDataSource.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2017/3/15.
//  Copyright © 2017年 Che Yongzi. All rights reserved.
//

import UIKit

struct UserCenterModel {
    var name: String
    var image: String
}

let UserCenterModels: [[UserCenterModel]] = [
    [UserCenterModel.init(name: "开通VIP会员", image: "icon_vip"),
     UserCenterModel.init(name: "消息中心", image: "icon_message")],
    [UserCenterModel.init(name: "播放记录", image: "icon_history"),
     UserCenterModel.init(name: "离线缓存", image: "icon_download"),
     UserCenterModel.init(name: "我的收藏", image: "icon_collection")],
    [UserCenterModel.init(name: "活动中心", image: "icon_activity"),
     UserCenterModel.init(name: "会员卡兑换", image: "icon_vip"),
     UserCenterModel.init(name: "帮助反馈", image: "icon_feedback"),
     UserCenterModel.init(name: "设置", image: "icon_set")],
]

class UserCenterViewSource: TableViewModel<UserCenterModel> {
    override var cellHeight: CGFloat {
        return 50
    }
    
    override func cellConfig(_ view: UITableView, datas: [[UserCenterModel]], indexPath: IndexPath) -> UITableViewCell {
        let cell = view.dequeueReusableCell(withIdentifier: "UserCenterCell", for: indexPath)
        return cell
    }
}
