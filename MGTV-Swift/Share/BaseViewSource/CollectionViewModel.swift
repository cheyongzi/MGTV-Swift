//
//  CollectionViewModel.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2016/12/22.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

typealias CollectionViewProtocol = UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

protocol ViewModelProtocol {
    associatedtype DataType
    
    var datas: [[DataType]] { get set }
    
    associatedtype ViewType
    associatedtype CellType
    
    func cellConfig(_ view: ViewType, datas: [[DataType]], indexPath: IndexPath) -> CellType
}

class CollectionViewModel<T>: NSObject, ViewModelProtocol, CollectionViewProtocol {

    typealias DataType = T
    typealias ViewType = UICollectionView
    typealias CellType = UICollectionViewCell
    
    var datas: [[T]] = []
    
    func cellConfig(_ view: UICollectionView, datas: [[T]], indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    var minimumLineSpacing: CGFloat { return 0 }
    var minimumInteritemSpacing: CGFloat { return 0 }
    var insetForSection: UIEdgeInsets { return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) }
    var itemSize: CGSize { return CGSize(width: 0, height: 0) }
    
    init(_ collectionDatas: [[T]]) {
        datas = collectionDatas
        super.init()
    }
    
    //MARK: - UICollectionView DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return datas.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return cellConfig(collectionView, datas: datas, indexPath: indexPath)
    }
    
    //MARK: UICollectionView DelegateFlowlayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //默认是page类型
        let itemSizeWith = itemSize.width == 0 ? collectionView.bounds.size.width : itemSize.width
        let itemSizeHeight = itemSize.height == 0 ? collectionView.bounds.size.height : itemSize.height
        return CGSize(width: itemSizeWith, height: itemSizeHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insetForSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
}
