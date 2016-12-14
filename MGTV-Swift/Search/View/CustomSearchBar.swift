//
//  CustomSearchBar.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 16/10/17.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit
import SnapKit

let defaultPlaceholder = "搜索视频、明星"

protocol CustomSearchBarDelegate: class {
    func search(text: String?)
    func clear()
    func auto(text: String?)
    func beginEdit()
    func touchAction(text: String?)
}

extension CustomSearchBarDelegate {
    func search(text: String?) { }
    func clear() { }
    func auto(text: String?) { }
    func beginEdit() { }
    func touchAction(text: String?) { }
}

class CustomSearchBar: UIView, UITextFieldDelegate {
    
    weak var delegate: CustomSearchBarDelegate?
    
    /// placeholder网络请求进行展示，默认为false
    var requestPlaceholder: Bool = false {
        didSet {
            if requestPlaceholder {
                SearchRecommendDataSource.fetchSearchRecommend(nil, complete: { [weak self] (response, error) in
                    guard let searchRecommendResponse = response as? SearchRecommendResponse else {
                        return
                    }
                    guard let searchRecommendItem = searchRecommendResponse.data?.first else {
                        return
                    }
                    guard let recommendPlaceholder = searchRecommendItem.name else {
                        return
                    }
                    if let strongSelf = self {
                        strongSelf.placeholder = recommendPlaceholder
                    }
                    
                })
            }
        }
    }

    //text field is can edit
    var isCanEdit: Bool = true {
        didSet {
            if isCanEdit {
                textField.isUserInteractionEnabled = true
            } else {
                textField.isUserInteractionEnabled = false
            }
        }
    }
    //搜索框
    lazy private var textField: UITextField = { [unowned self] in
        let field = UITextField()
        field.font = UIFont.systemFont(ofSize: 13)
        field.clearButtonMode = .always
        field.returnKeyType = .search
        field.delegate = self
        field.addTarget(self, action: #selector(textFieldObserver(_:)), for: .editingChanged)
        return field
    }()
    //搜索图标
    lazy private var searchIcon: UIImageView = {
        let icon = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        icon.image = UIImage(named: "TabBar_SearchBox_icon")
        return icon
    }()
    //placeholder
    var placeholder: String {
        get {
            return textField.placeholder!
        }
        
        set {
            textField.attributedPlaceholder = NSAttributedString.init(string: newValue, attributes: [NSForegroundColorAttributeName : UIColor(red: 102.0/255, green: 102.0/255, blue: 102.0/255, alpha: 1.0)])
        }
    }
    //text
    var text: String? {
        get {
            return textField.text
        }
        
        set {
            textField.text = newValue
        }
    }

    //MARK: - Init method
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSearchBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initSearchBar()
        
    }
    
    //MARK: - UITextField Delegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if !isCanEdit {
            return false
        }
        delegate?.beginEdit()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        delegate?.clear()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text != nil && textField.text != "" {
            delegate?.search(text: textField.text)
        } else {
            if textField.placeholder != nil && textField.placeholder != defaultPlaceholder {
                delegate?.search(text: textField.placeholder)
            }
        }
        return true
    }
    
    //MARK: - Touch action
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isCanEdit {
            delegate?.touchAction(text: textField.placeholder)
        }
    }
    
    //MARK: - Init search bar
    private func initSearchBar() {
        
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        
        self.addSubview(textField)
        self.addSubview(searchIcon)
        
        textField.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        searchIcon.snp.makeConstraints { (make) in
            make.trailing.equalTo(textField.snp.leading).offset(-5)
            make.width.height.equalTo(10)
            make.centerY.equalTo(self)
        }
        
        placeholder = defaultPlaceholder
    }
    
    //MARK: - Text filed status observer
    @objc private func textFieldObserver(_ textField: UITextField) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(autoChange), object: nil)
        self.perform(#selector(autoChange), with: nil, afterDelay: 0.2)
    }
    
    @objc private func autoChange() {
        delegate?.auto(text: textField.text)
    }
    
    //MARK: - Update constraints
    override func updateConstraints() {
        if isCanEdit {
            textField.snp.removeConstraints()
            textField.snp.makeConstraints({ (make) in
                make.edges.equalTo(self).inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0))
            })
            
            textField.textAlignment = .left
        } else {
            textField.snp.removeConstraints()
            textField.snp.makeConstraints({ (make) in
                make.center.equalTo(self)
            })
            textField.textAlignment = .center
        }
        super.updateConstraints()
    }
    
    //MARK: - Become First Responder
    override func becomeFirstResponder() -> Bool {
        textField.becomeFirstResponder()
        return true
    }
}
