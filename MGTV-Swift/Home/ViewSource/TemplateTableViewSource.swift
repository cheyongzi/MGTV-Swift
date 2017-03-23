//
//  TemplateTableViewSource.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/10.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import CCAutoScrollView

let verticalHeight = (Int)(147.0*HNTVDeviceWidth/320.0)
let horizontalHeight = (Int)(88.0*HNTVDeviceWidth/320.0)
let bigHeight = (Int)(177.5*HNTVDeviceWidth/320.0)

let TemplateCellIndentiferDic: [String : (String, Int)] =
    [
        "title" : ("SectionTitleCell",51),
        "ipmodel" : ("TopicTitleCell", 71),
        "bcrossm" : ("OneTemplateCell", 66 + bigHeight),
        "nonbcross" : ("OneTemplateCell", 48 + bigHeight),
        "scrossm" : ("HorizontalTemplateCell", 66 + horizontalHeight),
        "noncross" : ("HorizontalTemplateCell", 48 + horizontalHeight),
        "hypsog" : ("VerticalTemplateCell", 66 + verticalHeight),
        "nonhypsog" : ("VerticalTemplateCell", 48 + verticalHeight),
        "banner" : ("BannerCell", 33 + (Int)(150*HNTVDeviceWidth/320.0)),
        "sugg2" : ("SuggestTemplateCell", 2 * (66 + horizontalHeight)),
        "sugg3" : ("SuggestTemplateCell", 2 * (48 + horizontalHeight)),
        "more" : ("MoreLinkCell", 53),
        "rank2" : ("RankVerticalCell", 66 + verticalHeight),
        "rank3" : ("RankVerticalCell", 48 + verticalHeight),
        //"advert" : ("ADTemplateCell", 108),
        "king" : ("OneTemplateCell", 66 + bigHeight),
        //"dfilter" : ("FilterCell", 86),
        //"fast" : ("FastCell", 43),
        "star" : ("StarsCell", 270),
        "circle" : ("FourCircleCell", 112),
        "vipac" : ("VIPACCell", 108),
        "basecell" : ("TemplateBaseTableViewCell", 0)
]

import UIKit

class HomeTableViewModel: TableViewModel<TemplateResponseData> {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        for (identifier, _) in TemplateCellIndentiferDic.values {
            tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.clipsToBounds = false
        
        return tableView
    }()
    
    override func caculateHeight(_ indexPath: IndexPath) -> CGFloat {
        let type = moduleType(datas[0][indexPath.row])
        return height(type)
    }
    
    override func cellConfig(_ view: UITableView, datas: [[TemplateResponseData]], indexPath: IndexPath) -> UITableViewCell {
        let type = moduleType(datas[0][indexPath.row])
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier(type))
        if let baseCell = cell as? TemplateBaseTableViewCell {
            let responseData = datas[0][indexPath.row]
            baseCell.configResponse(responseData: responseData, indexPath: indexPath)
            baseCell.selectionStyle = .none
        }
        
        return cell!;
    }
    
    //MARK: - 根据位置获取对应的cell的样式
    private func identifier(_ moduleType: String) -> String {
        if let (identifier, _) = TemplateCellIndentiferDic[moduleType] {
            return identifier;
        }
        return "TemplateBaseTableViewCell"
    }
    
    private func height(_ moduleType: String) -> CGFloat {
        if let (_, height) = TemplateCellIndentiferDic[moduleType] {
            return CGFloat(height)
        }
        return 0;
    }
    
    private func moduleType(_ data: TemplateResponseData) -> String {
        guard let identifer = data.moduleType else {
            return "basecell"
        }
        return identifer
    }
}
