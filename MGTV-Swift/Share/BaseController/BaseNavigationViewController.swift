//
//  BaseNavigationViewController.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/10.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        navigationBar.barStyle = .black
        navigationBar.barTintColor = UIColor.black
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        let space1 = self.barItem(-5)
        let space2 = self.barItem(20)
        if rootViewController.isKind(of: HomeViewController.self) {
            let downloadItem = self.barItem(imageName: "navigantionbar-download", frame: CGRect(x: 0, y: 0, width: 22, height: 22), selector: #selector(download))
            let recordItem = self.barItem(imageName: "navigantionbar-history", frame: CGRect(x: 0, y: 0, width: 22, height: 22), selector: #selector(record))
            rootViewController.navigationItem.rightBarButtonItems = [space1, recordItem, space2, downloadItem]
            
            rootViewController.navigationItem.leftBarButtonItem = self.barItem("navigantionBar_logo", frame: CGRect(x: 0, y: 0, width: 67, height: 20))
        } else if (rootViewController.isKind(of: VIPViewController.self)) {
            let searchItem = self.barItem(imageName: "Vip_navigantionbar-search", frame: CGRect(x: 0, y: 0, width: 22, height: 22), selector: #selector(search))
            rootViewController.navigationItem.rightBarButtonItem = searchItem
            rootViewController.navigationItem.titleView = UIImageView(image: UIImage(named: "Vip_Channel_VipLogo"))
        } else if (rootViewController.isKind(of: LiveViewController.self)) {
            let searchItem = self.barItem(imageName: "navigantionbar-search", frame: CGRect(x: 0, y: 0, width: 22, height: 22), selector: #selector(search))
            rootViewController.navigationItem.rightBarButtonItem = searchItem
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func download() {
        
    }
    
    func record() {
        
    }
    
    func search() {
        
    }

}
