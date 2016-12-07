//
//  BaseDataSource.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/14.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

protocol BaseDataSourceDelegate: class {
    
    /// 接口请求成功之后的回调
    ///
    /// - parameter response:   接口返回的response
    /// - parameter requestTag: 接口的标示，用于区分多个request,默认为空
    func success(_ response: Any?, requestTag: String?)
    
    /// 接口请求失败
    ///
    /// - parameter response:   接口返回的response
    /// - parameter requestTag: 接口的标示，用于区分多个request,默认为空
    /// - parameter error:      接口错误
    func failed(_ response: Any?, requestTag: String?, error: Error?)
}

/// 通过extension的方式实现protocol的optional
extension BaseDataSourceDelegate {
    func success(_ response: Any?, requestTag: String?) {
        
    }
    
    func failed(_ response: Any?, requestTag: String?, error: Error?) {
        
    }
}

class BaseDataSource: NSObject {

    weak var delegate: BaseDataSourceDelegate?
}
