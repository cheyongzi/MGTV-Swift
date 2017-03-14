//
//  StarsCell.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/13.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class StarsCollectionViewModel: CollectionViewModel<StarDataInfo> {
    override func cellConfig(_ view: UICollectionView, datas: [[StarDataInfo]], indexPath: IndexPath) -> UICollectionViewCell {
        let cell = view.dequeueReusableCell(withReuseIdentifier: "StarCollectionViewCell", for: indexPath)
        guard let starCell = cell as? StarCollectionViewCell else {
            return cell
        }
        starCell.starInfo = datas[0][indexPath.row]
        return starCell
    }
    
    override func itemSize(_ indexPath: IndexPath) -> CGSize {
        return CGSize(width: HNTVDeviceWidth/4, height: 135)
    }
}

class StarsCell: TemplateBaseTableViewCell {

    let starViewModel = StarsCollectionViewModel([])
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "StarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StarCollectionViewCell")
        collectionView.dataSource = starViewModel
        collectionView.delegate = starViewModel
    }
    
    override func configResponse(responseData: TemplateResponseData?, indexPath: IndexPath?) {
        guard let templateData = responseData else {
            return
        }
        let redirectValue = templateData.redirectStatus
        
        if redirectValue == 0 {
            
            StarDataSource.fetchStars(params: ["template" : templateData]){ [unowned self] (starResponse, error) in
                guard let templateResponse = starResponse as? TemplateResponseData else {
                    return
                }
                self.configResponse(responseData: templateResponse, indexPath: indexPath)
            }
        }
        
        guard let users = templateData.starData?.data?.users else {
            return
        }
        
        starViewModel.datas = [users]
        collectionView.reloadData()
    }

}
