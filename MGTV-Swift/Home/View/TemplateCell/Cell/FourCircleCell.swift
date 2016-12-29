//
//  FourCircleCell.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/13.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class FourCircleCollectionViewModel: CollectionViewModel<TemplateResponseItem> {
    override func cellConfig(_ view: UICollectionView, datas: [[TemplateResponseItem]], indexPath: IndexPath) -> UICollectionViewCell {
        let cell = view.dequeueReusableCell(withReuseIdentifier: "CircleCollectionViewCell", for: indexPath)
        guard let circleCell = cell as? CircleCollectionViewCell else {
            return cell
        }
        circleCell.templateItem = datas[0][indexPath.row]
        return circleCell
    }
    
    override func itemSize(_ indexPath: IndexPath) -> CGSize {
        return CGSize(width: HNTVDeviceWidth/4, height: 0)
    }
}

class FourCircleCell: TemplateBaseTableViewCell {
    
    let circleViewModel = FourCircleCollectionViewModel([])
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "CircleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CircleCollectionViewCell")
        collectionView.dataSource = circleViewModel
        collectionView.delegate = circleViewModel
    }
    
    override func configResponse(responseData: TemplateResponseData?, indexPath: IndexPath?) {
        guard let datas = responseData?.moduleData else {
            return
        }
        circleViewModel.datas = [datas]
        collectionView.reloadData()
    }
    
}
