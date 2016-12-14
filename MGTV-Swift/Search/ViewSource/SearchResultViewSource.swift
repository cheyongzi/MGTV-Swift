//
//  SearchResultViewSource.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2016/12/13.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class SearchResultViewSource: NSObject, UITableViewDataSource, UITableViewDelegate {

    weak var delegate: SearchViewSourceDelegate?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: HNTVDeviceWidth, height: HNTVDeviceHeight))
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    //MARK: - UITableView Delegate
    
    //MARK: - UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
