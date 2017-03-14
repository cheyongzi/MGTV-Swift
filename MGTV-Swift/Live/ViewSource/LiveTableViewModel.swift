//
//  LiveTableViewModel.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2017/1/16.
//  Copyright © 2017年 Che Yongzi. All rights reserved.
//

import UIKit

let LiveCellIndentiferDic: [String : (String, Int)] =
    [
        "channellive" : ("ChannelLiveCell", 80),
        "artist" : ("ArtistLiveCell", 60),
        "personallive" : ("PersonalLiveCell", 278),
        "title" : ("SectionTitleCell",51),
        "bcrossm" : ("OneTemplateCell", 68 + bigHeight),
        "scrossm" : ("HorizontalTemplateCell", 68 + horizontalHeight),
        "more" : ("MoreLinkCell", 53),
        "basecell" : ("TemplateBaseTableViewCell", 0)
]

class LiveTableViewModel: TableViewModel<TemplateResponseData> {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: HNTVDeviceWidth, height: HNTVDeviceHeight))
        tableView.separatorStyle = .none
        for (identifier, _) in LiveCellIndentiferDic.values {
            tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.clipsToBounds = false
        
        return tableView
    }()
    
    override var datas: [[TemplateResponseData]] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func caculateHeight(_ indexPath: IndexPath) -> CGFloat {
        let type = moduleType(datas[indexPath.section][indexPath.row])
        if type == "personallive" {
            guard let item = datas[indexPath.section][indexPath.row].moduleData?.first else {
                return 0
            }
            guard let title = item.subName, title != "" else {
                return HNTVDeviceWidth + 65
            }
            
            return ceil((title as NSString).boundingRect(with: CGSize.init(width: HNTVDeviceWidth-20, height: 1000), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14)], context: nil).size.height) + HNTVDeviceWidth + 85
        }
        return height(type)
    }
    
    override func cellConfig(_ view: UITableView, datas: [[TemplateResponseData]], indexPath: IndexPath) -> UITableViewCell {
        let type = moduleType(datas[indexPath.section][indexPath.row])
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier(type), for: indexPath)
        if let baseCell = cell as? TemplateBaseTableViewCell {
            let responseData = datas[indexPath.section][indexPath.row]
            baseCell.configResponse(responseData: responseData, indexPath: indexPath)
        }
        
        return cell;
    }
    
    //MARK: - 根据位置获取对应的cell的样式
    private func identifier(_ moduleType: String) -> String {
        if let (identifier, _) = LiveCellIndentiferDic[moduleType] {
            return identifier;
        }
        return "TemplateBaseTableViewCell"
    }
    
    private func height(_ moduleType: String) -> CGFloat {
        if let (_, height) = LiveCellIndentiferDic[moduleType] {
            return CGFloat(height)
        }
        return 0
    }
    
    private func moduleType(_ data: TemplateResponseData) -> String {
        guard let identifer = data.moduleType else {
            return "basecell"
        }
        return identifer
    }
}
