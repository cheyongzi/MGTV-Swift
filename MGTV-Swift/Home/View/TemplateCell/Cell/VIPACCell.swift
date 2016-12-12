//
//  VIPACCell.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/13.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class VIPACCell: TemplateBaseTableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBAction func buttonAction(_ sender: AnyObject) {
    }
    
    override func configResponse(responseData: TemplateResponseData?, indexPath: IndexPath?) {
        guard let item = responseData?.moduleData?.first else {
            return
        }
        var orignImgStr: String?
        if !isEmpty(data: item.phoneImgUrl) {
            orignImgStr = item.phoneImgUrl
        } else {
            orignImgStr = item.imgHUrl
        }
        if let path = orignImgStr {
            let pathEx = path.pathExtension()
            let imgStr = path.appending("_738x200.\(pathEx)")
            iconImageView.kf.setImage(with: URL(string: imgStr))
        } else {
            iconImageView.kf.setImage(with: URL(string: ""))
        }
    }

}
