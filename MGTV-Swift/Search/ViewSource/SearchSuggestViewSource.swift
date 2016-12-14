//
//  SearchSuggestViewSource.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2016/12/14.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class SearchSuggestViewSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Property
    weak var delegate: SearchViewSourceDelegate?

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 64, width: HNTVDeviceWidth, height: HNTVDeviceHeight-64))
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "SearchSuggestCell", bundle: nil), forCellReuseIdentifier: "SearchSuggestCell")
        return tableView
    }()
    
    var datas: [SearchSuggestItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: - Init
    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboadDidAppear(_:)), name: .UIKeyboardDidShow, object: nil)
    }
    
    //MARK: - Keyboard notification
    func keyboadDidAppear(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    //MARK: - UITableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = datas[indexPath.row]
        guard let name = item.name else {
            return
        }
        delegate?.startSearch(name)
    }
    
    //MARK: - UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchSuggestCell", for: indexPath)
        if let suggestCell = cell as? SearchSuggestCell {
            suggestCell.nameLabel.text = datas[indexPath.row].name
        }
        return cell
    }
}
