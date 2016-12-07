//
//  BaseTabBarController.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/6/24.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    let titles: [String] = ["精选","直播","关注","VIP","我"];
    
    static let mainController: BaseTabBarController = BaseTabBarController()
    
    override func viewDidLoad() {
        let homeController = HomeViewController()
        let liveController = LiveViewController()
        let followController = FollowViewController()
        let vipController = VIPViewController()
        let userController = UserCenterViewController()
        let controllerArray = [BaseNavigationViewController(rootViewController: homeController),
                               BaseNavigationViewController(rootViewController: liveController),
                               BaseNavigationViewController(rootViewController: followController),
                               BaseNavigationViewController(rootViewController: vipController),
                               BaseNavigationViewController(rootViewController: userController)]
        
        for (index, controller) in controllerArray.enumerated() {
            controller.tabBarItem.image = UIImage(named: "tabbar_icon\(index+1)")?.withRenderingMode(.alwaysOriginal)
            controller.tabBarItem.selectedImage = UIImage(named: "tabbar_icon\(index+1)_pre")?.withRenderingMode(.alwaysOriginal)
            controller.tabBarItem.title = titles[index];
            controller.tabBarItem.setTitleTextAttributes([NSFontAttributeName : UIFont.boldSystemFont(ofSize: 10), NSForegroundColorAttributeName : UIColor(red: 170.0/255, green: 170.0/255, blue: 170.0/255, alpha: 1.0)], for: .normal);
            controller.tabBarItem.setTitleTextAttributes([NSFontAttributeName : UIFont.boldSystemFont(ofSize: 10), NSForegroundColorAttributeName : UIColor.black], for: .selected);
        }
        
        self.viewControllers = controllerArray
    }
}
