//
//  BannerCell.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/20.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import CCAutoScrollView

class BannerCell: TemplateBaseTableViewCell, CCAutoScrollViewDelegate {

    @IBOutlet weak var autoScrollView: CCAutoScrollView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoScrollView.cellNibName = "CustomBannerAutoCell"
        autoScrollView.autoScrollTimeInterval = 3.5
        autoScrollView.cellConfig = {(cell, data) in
            guard let bannerAutoCell = cell as? CustomBannerAutoCell else {
                return
            }
            guard let moduleItem = data as? TemplateResponseItem else {
                bannerAutoCell.imageView.image = nil
                return
            }
            var imgUrlStr = ""
            if !isEmpty(data: moduleItem.phoneImgUrl) {
                imgUrlStr = moduleItem.phoneImgUrl!
            } else if !isEmpty(data: moduleItem.imgHUrl) {
                imgUrlStr = moduleItem.imgHUrl!
            }
            let imgUrl = URL(string: imgUrlStr)
            bannerAutoCell.imageView.kf.setImage(with: imgUrl)
            if !isEmpty(data: moduleItem.mobileTitle) {
                bannerAutoCell.nameLabel.text = moduleItem.mobileTitle
            } else {
                bannerAutoCell.nameLabel.text = moduleItem.name
            }
        }
        autoScrollView.delegate = self
    }
    
    override func configResponse(responseData: TemplateResponseData?, indexPath: IndexPath?) {
        if let moduleData = responseData?.moduleData {
            autoScrollView.dataSource = moduleData
        }
    }
    
    //MARK: - CCAutoScrollViewDelegate
    func autoScrollView(_ scrollView: CCAutoScrollView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func autoScrollView(_ scrollView: CCAutoScrollView, scrollToItemAt indexPath: IndexPath) {
        
    }
}
