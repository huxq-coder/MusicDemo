//
//  HXQLicModel.swift
//  MusicDemo
//
//  Created by huxq-coder on 2020/7/22.
//  Copyright © 2020 huxq. All rights reserved.
//

import UIKit

/// 歌词数据模型
class HXQLicModel: NSObject {
    
    var lic: String?
    
    var time: String?
    
    
    init(lic: String) {
        super.init()
        
        let array = lic.components(separatedBy: "]")
        self.lic = array[1]
        self.time = array[0].components(separatedBy: "[")[1]
        
    }

}
