//
//  LiveViewController.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/10.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class LiveViewController: UIViewController {
    
    let liveModel: LiveTableViewModel = LiveTableViewModel([])

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationItem.title = "直播"
        
        view.addSubview(liveModel.tableView)
        
        LiveDataSource.fetchLive(params: nil) { [unowned self] (responseData, error) in
            guard let templateResponse = responseData as? TemplateResponse else {
                return
            }
            
            guard let datas = templateResponse.data else {
                return
            }
            
            self.liveModel.datas = [datas]
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
