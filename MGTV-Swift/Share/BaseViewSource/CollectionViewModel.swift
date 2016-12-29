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

class CollectionViewModel<T>: NSObject, ViewModelProtocol,CollectionViewProtocol {

    typealias DataType = T
    typealias ViewType = UICollectionView
    typealias CellType = UICollectionViewCell
    
    var datas: [[T]] = []
    
    func cellConfig(_ view: UICollectionView, datas: [[T]], indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func reusableView(_ view: UICollectionView, indexPath: IndexPath, kind: String) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
    
    func selectItem(_ indexPath: IndexPath) {
        
    }
    
    func itemSize(_ indexPath: IndexPath) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    func insetForSection(_ section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func minimumLineSpacing(_ section: Int) -> CGFloat {
        return 0
    }
    
    func minimumInteritemSpacing(_ section: Int) -> CGFloat {
        return 0
    }
    
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
    
    //MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectItem(indexPath)
    }
    
    //MARK: UICollectionView DelegateFlowlayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //默认是page类型
        let size = itemSize(indexPath);
        let itemSizeWith = size.width == 0 ? collectionView.bounds.size.width : size.width
        let itemSizeHeight = size.height == 0 ? collectionView.bounds.size.height : size.height
        return CGSize(width: itemSizeWith, height: itemSizeHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insetForSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return reusableView(collectionView, indexPath: indexPath, kind: kind)
    }
}
