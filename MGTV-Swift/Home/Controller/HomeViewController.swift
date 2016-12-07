//
//  HomeViewController.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/6/24.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit
import Alamofire
import CCAutoScrollView

class HomeViewController: UIViewController {
    let dataManager = TemplateDataManager.dataManager
    //MARK: - CollectionViewSource collection cell reload method
    var viewSource: TemplateCollectionViewSource!
    
    var data: String?

    //MARK: - View Did load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        closure {
            viewSource = TemplateCollectionViewSource("TemplateCollectionViewCell", data: []) { [unowned self] (cell, data) in
                guard let channelData = data as? ChannelResponseData else {
                    return
                }
                guard let collectionCell = cell as? TemplateCollectionViewCell else {
                    return
                }
                guard let channelId = channelData.vclassId else {
                    return
                }
                collectionCell.tableViewSource.tableView.setContentOffset(CGPoint(x: 0, y: self.dataManager.offset(channelId)), animated: false)
                let templateResponse = self.dataManager.template(channelId: channelId)
                self.dataManager.currentChannelId = channelId
                collectionCell.configCell(response: templateResponse)
            }
            viewSource.dataArray = dataManager.channelDatas()
            viewSource.viewSourceDelegate = self
        }
        view.addSubview(viewSource.collectionView)
        
        view.addSubview(viewSource.segment)
        
        TemplateDataSource.fetchChannel()
        
        self.fetch(["type" : "5", "version" : "5.0", "vclassId" : 60])
    }
    
    //MARK: - 首页接口的请求
    func fetch(_ params: [String : Any]) {
        TemplateDataSource.fetchTemplate(params: params){ [unowned self] (response, error) in
            guard !(error != nil) else {
                return
            }
            guard let templateResponse = response as? TemplateResponse else {
                return
            }
            guard let channelId = templateResponse.channel?.vclassId else {
                return
            }
            templateResponse.lastRequestTime = Date()
            self.dataManager.storeResponse(templateResponse, channelId: channelId)
            self.viewSource.collectionView.reloadData()
        }
    }
    

    //MARK: - ===========
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HomeViewController: TemplateCollectionViewSourceDelegate {
    //MARK: - TemplateCollectionView Source delegate
    func fetchTemplate(params: [String : Any]) {
        self.fetch(params)
    }
}
