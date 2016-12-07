//
//  CommonExtension.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/6/24.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

let HNTVDeviceHeight = UIScreen.main.bounds.size.height
let HNTVDeviceWidth = UIScreen.main.bounds.size.width

let HNTVNavigationBarHeight = 64
let HNTVTabBarHeight = 49

func +(leftSize: CGSize, rightSize: CGSize) -> CGSize {
    return CGSize(width: leftSize.width + rightSize.width, height: rightSize.height)
}

func isEmpty(data: Any?) -> Bool {
    if let stringValue = data as? String {
        if !stringValue.isEmpty {
            return false
        }
    }
    return true
}

extension String {
    func pathExtension() -> String {
        return (self as NSString).pathExtension
    }
}

extension UIColor {
    public convenience init(hexString: String) {
        let hexString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner   = Scanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        
        if scanner.scanHexInt32(&color) {
            self.init(hex: color)
        }
        else {
            self.init(hex: 0x000000)
        }
    }
    
    public convenience init(hex: UInt32) {
        let mask = 0x000000FF
        
        let r = Int(hex >> 16) & mask
        let g = Int(hex >> 8) & mask
        let b = Int(hex) & mask
        
        let red   = CGFloat(r) / 255
        let green = CGFloat(g) / 255
        let blue  = CGFloat(b) / 255
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
}
