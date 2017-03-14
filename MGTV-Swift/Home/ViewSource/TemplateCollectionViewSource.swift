//
//  TemplateCollectionViewSource.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/10.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

protocol TemplateCollectionViewSourceDelegate: class {
    func fetchTemplate(params: [String : Any])
}

extension TemplateCollectionViewSourceDelegate {
    func fetchTemplate(params: [String : Any]) {
        
    }
}

class HomeCollectionViewModel: CollectionViewModel<ChannelResponseData>, ChannelSegmentViewDelegate {
    
    weak var viewSourceDelegate: TemplateCollectionViewSourceDelegate?
    
    //MARK: - CollectionView
    lazy public private(set) var collectionView: UICollectionView = { [unowned self] in
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x:0, y:100, width:HNTVDeviceWidth, height:HNTVDeviceHeight-149), collectionViewLayout: flowLayout);
        collectionView.isPagingEnabled = true;
        collectionView.showsVerticalScrollIndicator = false;
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.scrollsToTop = false;
        collectionView.clipsToBounds = false;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = UIColor.white
        collectionView.register(TemplateCollectionViewCell.self, forCellWithReuseIdentifier: "TemplateCollectionViewCell")
        return collectionView;
        }()
    
    lazy public private(set) var segment: ChannelSegmentView = self.initSegment()
    
    private func initSegment() -> ChannelSegmentView {
        let segmentView = ChannelSegmentView(frame: CGRect(x: 0, y: 64, width: HNTVDeviceWidth, height: 36))
        var channelTitleDatas: [String] = []
        for channelData in datas[0] {
            channelTitleDatas.append(channelData.title ?? "")
        }
        segmentView.datas = channelTitleDatas
        segmentView.delegate = self
        return segmentView
    }
    
    override func cellConfig(_ view: UICollectionView, datas: [[ChannelResponseData]], indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TemplateCollectionViewCell", for: indexPath)
        guard let collectionCell = cell as? TemplateCollectionViewCell else {
            return cell
        }
        guard let channelId = datas[indexPath.section][indexPath.row].vclassId else  {
            return cell
        }
        collectionCell.setOffset(channelId)
        let templateResponse = TemplateDataManager.dataManager.template(channelId: channelId)
        TemplateDataManager.dataManager.currentChannelId = channelId
        collectionCell.configCell(response: templateResponse)
        return collectionCell
    }
    
    //MARK: - UIScollView delegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.frame.width)
        let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0))
        if let homeCell = cell as? TemplateCollectionViewCell {
            homeCell.storeOffset()
        }
        
    }
    //手动拖拽滑动会走这个方法
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollEnded(scrollView)
    }
    //scrolltoItem 会走这个方法
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollEnded(scrollView)
    }
    
    //MARK: - UICollectionView scroll animtaion end action
    private func scrollEnded(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        segment.move(index)
        let channelData = datas[0][index]
        guard let channelId = channelData.vclassId else {
            return
        }
        
        /// 判断接口数据是否失效
        let response = TemplateDataManager.dataManager.template(channelId: channelId)
        if response != nil {
            if let lastRequestTime = response?.lastRequestTime {
                let timeInterval = Date().timeIntervalSince(lastRequestTime)
                guard timeInterval > 500 else {
                    return
                }
            }
        }
        TemplateDataManager.dataManager.storeOffset(0, channelId: channelId)
        self.viewSourceDelegate?.fetchTemplate(params: ["type" : "5", "version" : "5.0", "vclassId" : channelId])
    }
    
    //MARK: - ChannelSegmentView Delegate
    func select(_ fromIndex: Int, toIndex: Int) {
        let cell = collectionView.cellForItem(at: IndexPath(item: fromIndex, section: 0))
        if let homeCell = cell as? TemplateCollectionViewCell {
            homeCell.storeOffset()
        }
        collectionView.scrollToItem(at: IndexPath(item: toIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
}
