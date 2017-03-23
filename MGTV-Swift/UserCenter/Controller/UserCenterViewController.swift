//
//  UserCenterViewController.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/6/24.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class UserCenterViewController: UIViewController {
    
    lazy var viewSource: UserCenterViewSource = {
        return UserCenterViewSource(UserCenterModels)
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds)
        tableView.backgroundColor = UIColor.white
        tableView.register(UINib.init(nibName: "SettingMainTableViewCell", bundle: nil), forCellReuseIdentifier: "UserCenterCell")
        tableView.delegate = self.viewSource
        tableView.dataSource = self.viewSource
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationItem.title = "个人中心"

        view.addSubview(tableView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
