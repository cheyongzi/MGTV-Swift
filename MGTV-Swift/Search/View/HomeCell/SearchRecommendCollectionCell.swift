//
//  SearchRecommendCollectionCell.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2016/12/12.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

protocol SearchConfigCellProtocol {
    func configCell(data: Any)
}

extension SearchConfigCellProtocol {
    func configCell(data: Any) {
        
    }
}

class SearchRecommendCollectionCell: UICollectionViewCell, SearchConfigCellProtocol {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(data: Any) {
        guard let recommendItem = data as? SearchRecommendItem else {
            return
        }
        guard let rank = recommendItem.rank else {
            return
        }
        switch rank {
        case 1:
            rankLabel.backgroundColor = UIColor(red: 246.0/255, green: 47.0/255, blue: 42.0/255, alpha: 1.0)
        case 2:
            rankLabel.backgroundColor = UIColor(red: 67.0/255, green: 159.0/255, blue: 253.0/255, alpha: 1.0)
        case 3:
            rankLabel.backgroundColor = UIColor(red: 47.0/255, green: 205.0/255, blue: 118.0/255, alpha: 1.0)
        default:
            rankLabel.backgroundColor = UIColor(red: 159.0/255, green: 168.0/255, blue: 177.0/255, alpha: 1.0)
        }
        rankLabel.text = "\(rank)"
        nameLabel.text = recommendItem.name
    }

}
