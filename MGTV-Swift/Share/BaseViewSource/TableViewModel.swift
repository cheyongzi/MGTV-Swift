//
//  TableViewModel.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2016/12/22.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

typealias TableViewProtocol = UITableViewDelegate & UITableViewDataSource

class TableViewModel<T>: NSObject, ViewModelProtocol, TableViewProtocol {
    typealias DataType = T
    
    typealias ViewType = UITableView
    typealias CellType = UITableViewCell
    
    var datas: [[T]] = []
    
    func cellConfig(_ view: UITableView, datas: [[T]], indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func caculateHeight(_ indexPath: IndexPath) -> CGFloat {
        return 0
    }
    
    func selectItem(_ indexPath: IndexPath) {
        
    }
    
    var cellHeight: CGFloat {
        return -1
    }
    
    init(_ tableDatas: [[T]]) {
        datas = tableDatas
        super.init()
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard cellHeight > 0 else {
            return caculateHeight(indexPath)
        }
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectItem(indexPath)
    }
    
    //MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return datas.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellConfig(tableView, datas: datas, indexPath: indexPath)
    }
}
