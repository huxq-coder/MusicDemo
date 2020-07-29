//
//  HXQLicModel.swift
//  MusicDemo
//
//  Created by huxq-coder on 2020/7/22.
//  Copyright © 2020 huxq. All rights reserved.
//

import UIKit

/// 歌词数据模型
class HXQLrcModel: NSObject {
    
    var lrc: String?
    
    var time: Double?
    
    override init() {
        
    }
    
    init(lic: String) {
        super.init()
        
        let array = lic.components(separatedBy: "]")
        self.lrc = array[1]
        // 00:09.06
        let timeString = array[0].components(separatedBy: "[")[1]
        let min = timeString[..<timeString.index(timeString.startIndex, offsetBy: 2)]
        let second = timeString[timeString.index(timeString.lastIndex(of: ":")!, offsetBy: 1)..<timeString.firstIndex(of: ".")!]
        self.time = Double(min)! * 60 + Double(second)! + 0.01 * Double(timeString[timeString.index(timeString.firstIndex(of: ".")!, offsetBy: 1)..<timeString.endIndex])!
    }
}
