//
//  AverageCollectionViewModel.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2016/12/5.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class AverageCollectionViewModel: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var identifier: String!
    var dataArray:  [Any]!
    var configCell: (UICollectionViewCell, Any) -> Void!
    var numberInLine: Int = 4
    var itemHeight: CGFloat = 0
    
    //MARK: - AverageCollectionViewModel Init Method
    init(_ identifier: String, data: [Any], configCell: @escaping (UICollectionViewCell, Any) -> Void, numberInLine: Int = 4, itemHeight: CGFloat = 0) {
        self.identifier = identifier
        self.dataArray = data
        self.configCell = configCell
        self.numberInLine = numberInLine
        self.itemHeight = itemHeight;
        super.init()
    }
    
    //MARK: - UICollectionView Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        configCell(cell, dataArray[indexPath.row])
        return cell
    }
    
    //MARK: - UICollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
        let itemHeight = self.itemHeight == 0 ? collectionView.bounds.size.height : self.itemHeight;
        return CGSize(width: HNTVDeviceWidth/CGFloat(numberInLine), height: itemHeight)
    }
    
}
