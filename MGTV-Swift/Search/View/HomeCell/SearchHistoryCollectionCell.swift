//
//  SearchHistoryCollectionCell.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2016/12/13.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class SearchHistoryCollectionCell: UICollectionViewCell, SearchConfigCellProtocol {

    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(data: Any) {
        guard let name = data as? String else {
            return
        }
        nameLabel.text = name
    }

}
