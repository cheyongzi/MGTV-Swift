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
        "title" : ("SectionTitleCell",38),
        "ipmodel" : ("TopicTitleCell", 68),
        "bcrossm" : ("OneTemplateCell", 53 + bigHeight),
        "nonbcross" : ("OneTemplateCell", 35 + bigHeight),
        "scrossm" : ("HorizontalTemplateCell", 53 + horizontalHeight),
        "noncross" : ("HorizontalTemplateCell", 35 + horizontalHeight),
        "hypsog" : ("VerticalTemplateCell", 53 + verticalHeight),
        "nonhypsog" : ("VerticalTemplateCell", 35 + verticalHeight),
        "banner" : ("BannerCell", 30 + (Int)(150*HNTVDeviceWidth/320.0)),
        "sugg2" : ("SuggestTemplateCell", 2 * (53 + horizontalHeight)),
        "sugg3" : ("SuggestTemplateCell", 2 * (35 + horizontalHeight)),
        "more" : ("MoreLinkCell", 46),
        "rank2" : ("RankVerticalCell", 35 + verticalHeight),
        "rank3" : ("RankVerticalCell", 53 + verticalHeight),
        //"advert" : ("ADTemplateCell", 108),
        "king" : ("OneTemplateCell", 53 + bigHeight),
        //"dfilter" : ("FilterCell", 86),
        //"fast" : ("FastCell", 43),
        "star" : ("StarsCell", 247),
        "circle" : ("FourCircleCell", 104),
        "vipac" : ("VIPACCell", 108),
        "basecell" : ("TemplateBaseTableViewCell", 0)
]

import UIKit

class TemplateTableViewSource: NSObject, UITableViewDelegate, UITableViewDataSource{

    var dataArray: [AnyObject] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    public private(set) var tableView: UITableView!
    
    init(frame: CGRect) {
        super.init()
        
        closure {
            tableView = UITableView(frame: frame)
            tableView.separatorStyle = .none
            for (identifier, _) in TemplateCellIndentiferDic.values {
                tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
            }
            tableView.delegate = self
            tableView.dataSource = self
            tableView.clipsToBounds = false
        }
    }
    
    //MARK: - UITableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let moduleType = self.moduleType(indexPath: indexPath)
        return self.height(moduleType: moduleType)
    }
    
    //MARK: - UITableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let moduleType = self.moduleType(indexPath: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier(moduleType: moduleType), for: indexPath)
        if let baseCell = cell as? TemplateBaseTableViewCell {
            let responseData = dataArray[indexPath.row] as? TemplateResponseData
            baseCell.configResponse(responseData: responseData, indexPath: indexPath)
        }
        
        return cell;
    }
    
    //MARK: - 根据位置获取对应的cell的样式
    func identifier(moduleType: String) -> String {
        if let (identifier, _) = TemplateCellIndentiferDic[moduleType] {
            return identifier;
        }
        return "TemplateBaseTableViewCell"
    }
    
    func height(moduleType: String) -> CGFloat {
        if let (_, height) = TemplateCellIndentiferDic[moduleType] {
            return CGFloat(height)
        }
        return 0;
    }
    
    func moduleType(indexPath: IndexPath) -> String {
        guard let data = dataArray[indexPath.row] as? TemplateResponseData else {
            return "basecell"
        }
        guard let identifer = data.moduleType else {
            return "basecell"
        }
        return identifer
    }
}
