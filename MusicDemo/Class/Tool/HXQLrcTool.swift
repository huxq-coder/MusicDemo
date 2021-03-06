//
//  HXQLicTool.swift
//  MusicDemo
//
//  Created by huxq-coder on 2020/7/22.
//  Copyright © 2020 huxq. All rights reserved.
//

import UIKit

/// 歌词工具类
class HXQLrcTool: NSObject {
    
    /// 通过歌曲名词获取歌词数组
    /// - Parameter licName: 歌曲名称
    class func licWithLicName(licName: String) -> [HXQLrcModel] {
        let path = Bundle.main.path(forResource: licName, ofType: nil)
        let lic = try! String.init(contentsOfFile: path!, encoding: .utf8)
        let lics = lic.components(separatedBy: "\n")
        var models = [HXQLrcModel]()
        for lineLic in lics {
            // 校验数据
            /**
            [ti:瓦解]
            [ar:南拳妈妈]
            [al:南拳妈妈的夏天]
             */
            guard lineLic.hasPrefix("[") else {
                continue
            }
            if lineLic.hasPrefix("[ti:") || lineLic.hasPrefix("[ar:") || lineLic.hasPrefix("[al:") {
                continue
            }
            let model = HXQLrcModel(lic: lineLic)
            models.append(model)
        }
        return models
    }

}
