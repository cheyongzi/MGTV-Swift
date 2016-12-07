//
//  ChannelSegmentView.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/18.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit
import CCAutoScrollView

protocol ChannelSegmentViewDelegate: class {
    func select(_ fromIndex: Int, toIndex: Int)
}

class ChannelSegmentView: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    weak var delegate: ChannelSegmentViewDelegate?
    
    private var currentIndex: Int = 0
    
    var datas: [String] = [] {
        didSet {
            collectionView.reloadData()
            collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        }
    }
    
    var width: CGFloat = 80
    
    public private(set) var collectionView: UICollectionView!
    
    //MARK: - Init method
    override init(frame: CGRect) {
        super.init(frame: frame)

        closure {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal
            collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.scrollsToTop = false
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.backgroundColor = UIColor.white
            collectionView.register(UINib(nibName: "ChannelSegmentCell", bundle: nil), forCellWithReuseIdentifier: "ChannelSegmentCell")
        }
        
        self.addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Move to destionation index
    func move(_ toIndex: Int) {
        collectionView.selectItem(at: IndexPath(item: toIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
    
    //MARK: - UICollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.select(currentIndex, toIndex: indexPath.row)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    //MARK: - UICollectionView Data Source
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ChannelSegmentCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChannelSegmentCell", for: indexPath) as! ChannelSegmentCell
        cell.titleLabel.text = datas[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    //MARK: - UICollectionView delegate flow layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: width, height: self.bounds.size.height)
    }

}
