//
//  BaseImageView.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2017/3/14.
//  Copyright © 2017年 Che Yongzi. All rights reserved.
//

import UIKit

enum BaseImageViewType {
    case Horizontal
    case Vertical
}

class BaseImageView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var rightBottomLabel: DesignLabel!
    @IBOutlet weak var rightTopLabel: DesignLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setUPXIB()
    }
    
    func setUPXIB() {
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func configTemplate(item: TemplateResponseItem?, picSize: String, imageType: BaseImageViewType = .Horizontal) {
        if !isEmpty(data: item?.cornerType){
            rightTopLabel.layerColor = UIColor(hexString: (item?.cornerType)!)
            rightTopLabel.text = " \((item?.rightCorner)!) "
            rightTopLabel.isHidden = false
        } else {
            rightTopLabel.isHidden = true
        }
        
        if !isEmpty(data: item?.updateInfo) {
            rightBottomLabel.text = " \((item?.updateInfo)!) "
            rightBottomLabel.isHidden = false
        } else {
            rightBottomLabel.isHidden = true
        }
        
        var orignImgStr: String?
        if !isEmpty(data: item?.phoneImgUrl) {
            orignImgStr = item?.phoneImgUrl
        } else {
            orignImgStr = imageType == .Horizontal ? item?.imgHUrl : item?.imgHVUrl
        }
        if let path = orignImgStr {
            let pathEx = path.pathExtension()
            let imgStr = path.appending("_\(picSize).\(pathEx)")
            backgroundImage.kf.setImage(with: URL(string: imgStr))
        } else {
            backgroundImage.kf.setImage(with: URL(string: ""))
        }
    }
    
    func configRecommand(item: RecommonResponseData?, picSize: String) {
        if !isEmpty(data: item?.desc) {
            rightBottomLabel.text = " \((item?.desc)!) "
            rightBottomLabel.isHidden = false
        } else {
            rightBottomLabel.isHidden = true
        }
        
        if let path = item?.image {
            let pathEx = path.pathExtension()
            let imgStr = path.appending("_\(picSize).\(pathEx)")
            backgroundImage.kf.setImage(with: URL(string: imgStr))
        } else {
            backgroundImage.kf.setImage(with: URL(string: ""))
        }
    }
}
