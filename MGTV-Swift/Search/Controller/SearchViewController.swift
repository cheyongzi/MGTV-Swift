//
//  SearchViewController.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2016/12/12.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var hasStartSearch = false
    
    let searchBar: CustomSearchBar = {
        let searchBar = CustomSearchBar.init(frame: CGRect(x: 0, y: 0, width: HNTVDeviceWidth, height: 30))
        return searchBar
    }()
    
    var placeholder: String? {
        didSet {
            searchBar.placeholder = placeholder ?? ""
        }
    }

    let homeViewSource = SearchHomeViewSource()
    
    lazy var suggestViewSource: SearchSuggestViewSource = SearchSuggestViewSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        self.navigationItem.leftBarButtonItem = self.barItem(title: "", frame: CGRect(x: 0, y: 0, width: 0, height: 0), selector: nil)
        self.navigationItem.rightBarButtonItems = [self.barItem(-10), self.barItem(title: "取消", frame: CGRect(x: 0, y: 0, width: 40, height: 44), selector: #selector(cancelSearch))]
        // Do any additional setup after loading the view.
        
        SearchRecommendDataSource.fetchSearchRecommend(nil, complete: { [weak self] (response, error) in
            guard let recommendData = response as? SearchRecommendResponse else {
                return
            }
            guard let datas = recommendData.data else {
                return
            }
            if let strongSelf = self {
                strongSelf.homeViewSource.recommendDatas = datas
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        let _ = searchBar.becomeFirstResponder()
        
        homeViewSource.searchViewModel.delegate = self
        view.addSubview(homeViewSource.collectionView)
        
        view.addSubview(suggestViewSource.tableView)
        suggestViewSource.tableView.isHidden = true
    }
    
    //MARK: - cancel action
    func cancelSearch() {
        searchBar.endEditing(true)
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    func searchAction(text: String) {
        SearchHistoryManager.saveHistory(text)
        hasStartSearch = true
//        SearchResultDataSource.fetchSearch(["name" : text]) { [weak self] (response, error) in
//            
//        }
    }

    //MARK: - MemoryWarning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SearchViewController: SearchViewSourceDelegate {
    func endEdit() {
        searchBar.endEditing(true)
    }
    
    func startSearch(_ text: String) {
        searchAction(text: text)
    }
}

extension SearchViewController: CustomSearchBarDelegate {
    func search(text: String?) {
        guard let searchText = text else {
            return
        }
        searchAction(text: searchText)
    }
    
    func auto(text: String?) {
        if !hasStartSearch {
            guard let suggestText = text else {
                return
            }
            guard !suggestText.isEmpty else {
                suggestViewSource.tableView.isHidden = true
                return
            }
            if suggestViewSource.tableView.isHidden {
                suggestViewSource.tableView.isHidden = false
            }
            SearchSuggestDataSource.fetchSuggest(["name" : suggestText], complete: { [weak self] (response, error) in
                guard let suggestResponse = response as? SearchSuggestResponse else {
                    return
                }
                guard let datas = suggestResponse.data else {
                    return
                }
                if let strongSelf = self {
                    strongSelf.suggestViewSource.suggestDatas = datas
                }
            })
        }
    }
    
    func clear() {
        hasStartSearch = false
        suggestViewSource.tableView.isHidden = true
    }
    
    func beginEdit() {
        
    }
}
