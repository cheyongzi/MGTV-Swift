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
    //MARK: - CollectionViewSource collection cell reload method
    let viewModel: HomeCollectionViewModel = HomeCollectionViewModel([TemplateDataManager.dataManager.channelDatas()])
    //MARK: - SearchBar
    let searchBar: CustomSearchBar = {
        let searchBar = CustomSearchBar.init(frame: CGRect(x: 0, y: 0, width: HNTVDeviceWidth-180, height: 30))
        searchBar.isCanEdit = false
        searchBar.requestPlaceholder = true
        return searchBar
    }()
    
    var data: String?

    //MARK: - View Did load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        viewModel.viewSourceDelegate = self
        
        view.addSubview(viewModel.collectionView)
        
        view.addSubview(viewModel.segment)
        
        TemplateDataSource.fetchChannel()
        
        self.fetch(["type" : "5", "version" : "5.0", "vclassId" : 60])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    //MARK: - 首页接口的请求
    func fetch(_ params: Parameters) {
        TemplateDataSource.fetchTemplate(params) { (response, error) in
            guard let templateResponse = response as? TemplateResponse else {
                return
            }
            guard let channelId = templateResponse.channel?.vclassId else {
                return
            }
            templateResponse.lastRequestTime = Date()
            TemplateDataManager.dataManager.storeResponse(templateResponse, channelId: channelId)
            self.viewModel.collectionView.reloadData()
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

extension HomeViewController: CustomSearchBarDelegate {
    func touchAction(text: String?) {
        let searchController = SearchViewController()
        searchController.hidesBottomBarWhenPushed = true
        searchController.placeholder = text
        self.navigationController?.pushViewController(searchController, animated: true)
    }
}
