//
//  BaseView57.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/13.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit
import Kingfisher

class BaseView: UIView {
    
    var viewData: AnyObject?
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var baseImageView: BaseImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUPXIB()
    }
    
    func config(templateItem item: TemplateResponseItem?, isDesc: Bool, picSize: String) {
        viewData = item
        //名称判断
        var name: String?
        if !isEmpty(data: item?.mobileTitle) {
            name = item?.mobileTitle
        } else {
            name = item?.name
        }
        nameLabel.text = name
        //描述信息判断 
        if isDesc {
            descLabel.isHidden = true
        } else {
            descLabel.isHidden = false
            descLabel.text = item?.subName
        }
    }
    
    func config(recommondItem item: RecommonResponseData?, isDesc: Bool, picSize: String) {
        viewData = item
        //名称判断
        nameLabel.text = item?.name
        //描述信息判断
        if isDesc {
            descLabel.isHidden = true
        } else {
            descLabel.isHidden = false
            descLabel.text = item?.title
        }
        
        baseImageView.configRecommand(item: item, picSize: picSize)
    }
    
    func setUPXIB() {
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        view.frame = self.bounds
        self.addSubview(view)
    }
}


class BaseView57: BaseView {
    
    //MARK: - config cell method
    override func config(templateItem item: TemplateResponseItem?, isDesc: Bool, picSize: String) {
        super.config(templateItem: item, isDesc: isDesc, picSize: picSize)
        
        baseImageView.configTemplate(item: item, picSize: picSize, imageType: .Vertical)
    }
    
}
