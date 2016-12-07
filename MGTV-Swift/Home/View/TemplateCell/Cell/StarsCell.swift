//
//  StarsCell.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/13.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class StarsCell: TemplateBaseTableViewCell {

    lazy var averageSource: AverageCollectionViewModel = AverageCollectionViewModel("StarCollectionViewCell", data: [], configCell: { [unowned self] (cell, data) in
        guard let itemData = data as? StarDataInfo else {
            return
        }
        
        guard let starCell = cell as? StarCollectionViewCell else {
            return
        }
        
        starCell.starInfo = itemData
    }, itemHeight:123)
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "StarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StarCollectionViewCell")
        collectionView.dataSource = averageSource
        collectionView.delegate = averageSource
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
        
        guard let starData = templateData.starData else {
            return
        }
        
        averageSource.dataArray = starData.data?.users
        collectionView.reloadData()
    }

}
