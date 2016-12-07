//
//  FourCircleCell.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/13.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class FourCircleCell: TemplateBaseTableViewCell {
    
    lazy var averageSource: AverageCollectionViewModel = AverageCollectionViewModel("CircleCollectionViewCell", data: [], configCell: { [unowned self] (cell, data) in
        guard let itemData = data as? TemplateResponseItem else {
            return
        }
        
        guard let circleCell = cell as? CircleCollectionViewCell else {
            return
        }
        
        circleCell.templateItem = itemData
    })
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "CircleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CircleCollectionViewCell")
        collectionView.dataSource = averageSource
        collectionView.delegate = averageSource
    }
    
    override func configResponse(responseData: TemplateResponseData?, indexPath: IndexPath?) {
        averageSource.dataArray = responseData?.moduleData
        collectionView.reloadData()
    }
    
}
