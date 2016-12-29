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

class SearchCollectionViewSource: CollectionViewModel<Any> {
    weak var delegate: SearchViewSourceDelegate?
    
    //MARk: - HistroyData
    private var historyData: [String] {
        return SearchHistoryManager.historyData()
    }
    
    private var hasHistory: Bool {
        guard historyData.count > 0 else {
            return false
        }
        return true
    }
    
    //MARK: - CollectionViewModel
    override func itemSize(_ indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            if hasHistory {
                return CGSize(width: HNTVDeviceWidth/2 - 15, height: 40)
            }
        }
        return CGSize(width: HNTVDeviceWidth/2 - 15, height: 50)
    }
    
    override func insetForSection(_ section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 20, right: 10)
    }
    
    override func minimumLineSpacing(_ section: Int) -> CGFloat {
        return 10
    }
    
    override func minimumInteritemSpacing(_ section: Int) -> CGFloat {
        return 10
    }
    
    override func cellConfig(_ view: UICollectionView, datas: [[Any]], indexPath: IndexPath) -> UICollectionViewCell {
        var cell = view.dequeueReusableCell(withReuseIdentifier: "SearchRecommendCollectionCell", for: indexPath)
        if indexPath.section == 0 {
            if hasHistory {
                cell = view.dequeueReusableCell(withReuseIdentifier: "SearchHistoryCollectionCell", for: indexPath)
            }
        }
        if let configCell = cell as? SearchConfigCellProtocol {
            configCell.configCell(data: datas[indexPath.section][indexPath.row])
        }
        return cell
    }
    
    override func reusableView(_ view: UICollectionView, indexPath: IndexPath, kind: String) -> UICollectionReusableView {
        let reusableView = view.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SearchTitleReusableView", for: indexPath)
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
    
    override func selectItem(_ indexPath: IndexPath) {
        let data = datas[indexPath.section][indexPath.row]
        if let history = data as? String {
            delegate?.startSearch(history)
        } else if let recommendItem = data as? SearchRecommendItem {
            guard let name = recommendItem.name else {
                return
            }
            delegate?.startSearch(name)
        }
    }
    
    //MARK: - UICollectionReusableView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            if hasHistory {
                return CGSize(width: HNTVDeviceWidth, height: 44)
            }
        }
        return CGSize(width: HNTVDeviceWidth, height: 33)
    }
    
    //MARK: - UIScrollViewDelegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        delegate?.endEdit()
    }
    
    //MARK: - Datas init
    var recommendDatas: [SearchRecommendItem] = [] {
        didSet {
            datas = [historyData,recommendDatas]
        }
    }
}


class SearchHomeViewSource:NSObject {
    
    var searchViewModel = SearchCollectionViewSource([])
    
    lazy var collectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        flowlayout.headerReferenceSize = CGSize(width: HNTVDeviceWidth, height: 44)
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: HNTVDeviceWidth, height: HNTVDeviceHeight), collectionViewLayout: flowlayout)
        collectionView.dataSource = self.searchViewModel
        collectionView.delegate = self.searchViewModel
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib.init(nibName: "SearchRecommendCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SearchRecommendCollectionCell")
        collectionView.register(UINib.init(nibName: "SearchHistoryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SearchHistoryCollectionCell")
        collectionView.register(UINib.init(nibName: "SearchTitleReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SearchTitleReusableView")
        return collectionView
    }()
    
    var recommendDatas: [SearchRecommendItem] = [] {
        didSet {
            searchViewModel.recommendDatas = recommendDatas
            collectionView.reloadData()
        }
    }
}
