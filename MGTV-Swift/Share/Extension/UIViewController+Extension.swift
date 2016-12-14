//
//  UIViewController+Extension.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/17.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

extension UIViewController {
    func barItem(_ imageName: String, frame: CGRect) -> UIBarButtonItem {
        let imageView = UIImageView.init(frame: frame)
        imageView.image = UIImage(named: imageName)
        let barItem = UIBarButtonItem(customView: imageView)
        return barItem
    }
    
    func barItem(imageName: String, frame: CGRect, selector: Selector?) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.frame = frame
        button.setImage(UIImage(named: imageName), for: .normal)
        if let sel = selector {
            button.addTarget(self, action: sel, for: .touchUpInside)
        }
        let item = UIBarButtonItem(customView: button)
        return item
    }
    
    func barItem(title: String, frame: CGRect, selector: Selector?) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.frame = frame
        button.setAttributedTitle(NSAttributedString(string: title, attributes: [NSForegroundColorAttributeName : UIColor.white, NSFontAttributeName : UIFont.systemFont(ofSize: 15)]), for: .normal)
        if let sel = selector {
            button.addTarget(self, action: sel, for: .touchUpInside)
        }
        
        let item = UIBarButtonItem(customView: button)
        return item
    }
    
    func barItem(_ width: CGFloat) -> UIBarButtonItem {
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space.width = width
        return space
    }
}

extension UIViewController {
    static func visibleController(_ viewController: UIViewController) -> UIViewController {
        if let controller = viewController.presentedViewController {
            return UIViewController.visibleController(controller)
        } else if let navController = viewController as? UINavigationController {
            guard navController.viewControllers.count > 0 else {
                return viewController
            }
            return UIViewController.visibleController(navController.topViewController!)
        } else if let tabBarController = viewController as? UITabBarController {
            guard (tabBarController.viewControllers?.count)! > 0 else {
                return viewController
            }
            return UIViewController.visibleController(tabBarController.selectedViewController!)
        }else {
            return viewController
        }
    }
    
    static func currentController() -> UIViewController {
        let viewController = BaseTabBarController.mainController
        return UIViewController.visibleController(viewController)
    }
}
