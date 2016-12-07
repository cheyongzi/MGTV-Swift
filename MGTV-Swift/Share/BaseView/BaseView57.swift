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
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var updateLabel: DesignLabel!
    @IBOutlet weak var rightCornerLabel: DesignLabel!
    
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
        
        if !isEmpty(data: item?.cornerType){
            rightCornerLabel.layerColor = UIColor(hexString: (item?.cornerType)!)
            rightCornerLabel.text = " \((item?.rightCorner)!) "
            rightCornerLabel.isHidden = false
        } else {
            rightCornerLabel.isHidden = true
        }
        
        if !isEmpty(data: item?.updateInfo) {
            updateLabel.text = " \((item?.updateInfo)!) "
            updateLabel.isHidden = false
        } else {
            updateLabel.isHidden = true
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
        
        if !isEmpty(data: item?.desc) {
            updateLabel.text = " \((item?.desc)!) "
            updateLabel.isHidden = false
        } else {
            updateLabel.isHidden = true
        }
        
        rightCornerLabel.isHidden = true
        
        if let path = item?.image {
            let pathEx = path.pathExtension()
            let imgStr = path.appending("_\(picSize).\(pathEx)")
            imageView.kf.setImage(with: URL(string: imgStr))
        } else {
            imageView.kf.setImage(with: URL(string: ""))
        }
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
        viewData = item
        
        super.config(templateItem: item, isDesc: isDesc, picSize: picSize)
        
        var orignImgStr: String?
        if !isEmpty(data: item?.phoneImgUrl) {
            orignImgStr = item?.phoneImgUrl
        } else {
            orignImgStr = item?.imgHVUrl
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
