//
//  VIPViewController.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/10.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class VIPViewController: UIViewController {
    
    let viewSource: HomeTableViewModel = HomeTableViewModel([])

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        self.navigationItem.title = "VIP"
        
        viewSource.tableView.frame = view.bounds
        view.addSubview(viewSource.tableView)
        
        self.fetch(["type" : "5", "version" : "5.0", "vclassId" : 68])
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - VIP频道接口的请求
    func fetch(_ params: [String : Any]) {
        TemplateDataSource.fetchTemplate(params){ [unowned self] (response, error) in
            guard let templateResponse = response as? TemplateResponse else {
                return
            }
            guard let datas = templateResponse.data else {
                return
            }
            self.viewSource.datas = [datas]
            self.viewSource.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
