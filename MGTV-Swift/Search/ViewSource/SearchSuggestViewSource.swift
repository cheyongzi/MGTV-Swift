//
//  SearchSuggestViewSource.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2016/12/14.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class SearchSuggestTableViewSource: TableViewModel<SearchSuggestItem> {
    weak var delegate: SearchViewSourceDelegate?
    
    override var cellHeight: CGFloat {
        return 44
    }
    
    override func cellConfig(_ view: UITableView, datas: [[SearchSuggestItem]], indexPath: IndexPath) -> UITableViewCell {
        let cell = view.dequeueReusableCell(withIdentifier: "SearchSuggestCell", for: indexPath)
        if let suggestCell = cell as? SearchSuggestCell {
            suggestCell.nameLabel.text = datas[indexPath.section][indexPath.row].name
        }
        return cell
    }
    
    //MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = datas[indexPath.section][indexPath.row]
        guard let name = item.name else {
            return
        }
        delegate?.startSearch(name)
    }
}

class SearchSuggestViewSource: NSObject {
    
    var suggestDatas: [SearchSuggestItem] = [] {
        didSet {
            suggestViewSource.datas = [suggestDatas]
            tableView.reloadData()
        }
    }
    
    let suggestViewSource = SearchSuggestTableViewSource([])

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 64, width: HNTVDeviceWidth, height: HNTVDeviceHeight-64))
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self.suggestViewSource
        tableView.dataSource = self.suggestViewSource
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "SearchSuggestCell", bundle: nil), forCellReuseIdentifier: "SearchSuggestCell")
        return tableView
    }()
    
    //MARK: - Init
    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboadDidAppear(_:)), name: .UIKeyboardDidShow, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Keyboard notification
    func keyboadDidAppear(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
}
