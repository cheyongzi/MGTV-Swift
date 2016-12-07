//
//  BaseView169.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/13.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit
import Kingfisher

class BaseView169: BaseView {
    
    //MARK: - config cell method
    override func config(templateItem item: TemplateResponseItem?, isDesc: Bool, picSize: String) {
        super.config(templateItem: item, isDesc: isDesc, picSize: picSize)
        var orignImgStr: String?
        if !isEmpty(data: item?.phoneImgUrl) {
            orignImgStr = item?.phoneImgUrl
        } else {
            orignImgStr = item?.imgHUrl
        }
        if let path = orignImgStr {
            let pathEx = path.pathExtension()
            let imgStr = path.appending("_\(picSize).\(pathEx)")
            imageView.kf.setImage(with: URL(string: imgStr))
        } else {
            imageView.kf.setImage(with: URL(string: ""))
        }
    }
    
    override func config(recommondItem item: RecommonResponseData?, isDesc: Bool, picSize: String) {
        super.config(recommondItem: item, isDesc: isDesc, picSize: picSize)
    }

}
