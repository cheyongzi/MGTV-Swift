//
//  SearchHomeViewSource.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2016/12/12.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

protocol SearchViewSourceDelegate: class {
    func endEdit()
    func startSearch(_ text: String)
}

class SearchHomeViewSource:NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - property
    weak var delegate: SearchViewSourceDelegate?
    
    private var hasHistory: Bool = false {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var recommendData: [SearchRecommendItem] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private var historyData: [String] = SearchHistoryManager.historyData()
    
    lazy var collectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: HNTVDeviceWidth, height: HNTVDeviceHeight), collectionViewLayout: flowlayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib.init(nibName: "SearchRecommendCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SearchRecommendCollectionCell")
        collectionView.register(UINib.init(nibName: "SearchHistoryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SearchHistoryCollectionCell")
        collectionView.register(UINib.init(nibName: "SearchTitleReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SearchTitleReusableView")
        return collectionView
    }()
    
    //MARK: - Init
    override init() {
        super.init()
        if historyData.count > 0 {
            hasHistory = true
        }
    }
    
    //MARK: - data for index path
    private func cellData(_ indexPath: IndexPath) -> Any {
        if indexPath.section == 0 {
            if hasHistory {
                return historyData[indexPath.row]
            }
        }
        return recommendData[indexPath.row]
    }
    
    //MARK: - reload collectionview
    func reload() {
        historyData = SearchHistoryManager.historyData()
        if historyData.count > 0 {
            hasHistory = true
        }
    }
    
    //MARK: - UICollectionView DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return hasHistory ? 2 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            if hasHistory {
                return historyData.count
            }
        }
        return recommendData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchRecommendCollectionCell", for: indexPath)
        if indexPath.section == 0 {
            if hasHistory {
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchHistoryCollectionCell", for: indexPath)
            }
        }
        if let configCell = cell as? SearchConfigCellProtocol {
            configCell.configCell(data: cellData(indexPath))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SearchTitleReusableView", for: indexPath)
        guard let titleReusableView = reusableView as? SearchTitleReusableView else {
            return reusableView
        }
        if indexPath.section == 0 {
            titleReusableView.nameLabel.text = hasHistory ? "搜索历史" : "热门搜索"
        } else if indexPath.section == 1 {
            titleReusableView.nameLabel.text = "热门搜索"
        }
        return titleReusableView
    }
    
    //MARK: - UICollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = cellData(indexPath)
        var searchText: String = ""
        if let text = data as? String {
            searchText = text
        }
        if let item = data as? SearchRecommendItem, let name = item.name {
            searchText = name
        }
        delegate?.startSearch(searchText)
    }
    
    //MARK: - UIScrollView Delegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        delegate?.endEdit()
    }
    
    //MARK: - UICollection Delegate Flowlayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            if hasHistory {
                return CGSize(width: HNTVDeviceWidth/2 - 15, height: 40)
            }
        }
        return CGSize(width: HNTVDeviceWidth/2 - 15, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 20, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            if hasHistory {
                return CGSize(width: HNTVDeviceWidth, height: 44)
            }
        }
        return CGSize(width: HNTVDeviceWidth, height: 33)
    }
}
