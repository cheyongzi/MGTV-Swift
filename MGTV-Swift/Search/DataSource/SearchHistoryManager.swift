//
//  SearchHistoryManager.swift
//  MGTV-Swift
//
//  Created by Che Yongzi on 2016/12/13.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import Foundation

struct SearchHistoryManager {
    static func saveHistory(_ text: String) {
        if var datas = UserDefaults.standard.array(forKey: "SearchHistory") as? [String] {
            var oldIndex = -1
            for (index, value) in datas.enumerated() {
                if value == text {
                    oldIndex = index
                    break
                }
            }
            if oldIndex != -1 {
                datas.remove(at: oldIndex)
            } else {
                if datas.count >= 6 {
                    datas.removeLast()
                }
            }
            datas.insert(text, at: 0)
            UserDefaults.standard.set(datas, forKey: "SearchHistory")
            UserDefaults.standard.synchronize()
        } else {
            var datas: [String] = []
            datas.append(text)
            UserDefaults.standard.set(datas, forKey: "SearchHistory")
            UserDefaults.standard.synchronize()
        }
    }
    
    static func historyData() -> [String] {
        guard let data = UserDefaults.standard.array(forKey: "SearchHistory") as? [String] else {
            return []
        }
        return data
    }
}
