//
//  PageCollectionViewModel.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/10.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

/*  该ViewModel主要用于Page类型的CollectionView
 *  单独采用PageCollectionViewModel的方式，可以保证viewmodel功能的唯一性，
 *  尽量不存在不同类型的collectionview使用同一个ViewModel
 */
class PageCollectionViewModel: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    
    var identifier: String!
    var dataArray:  [Any]!
    var configCell: (UICollectionViewCell, Any) -> Void!
    
    //MARK: - PageCollectionViewModel Init Method
    init(_ identifier: String, data: [Any], configCell: @escaping (UICollectionViewCell, Any) -> Void) {
        self.identifier = identifier
        self.dataArray = data
        self.configCell = configCell
        super.init()
    }
    
    //MARK: - UICollectionView Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        configCell(cell, dataArray[indexPath.row])
        return cell
    }
    
    //MARK: - UICollectionView Flow Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}
