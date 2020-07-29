//
//  HXQLicLabel.swift
//  MusicDemo
//
//  Created by evc_admin on 2020/7/29.
//  Copyright © 2020 huxq. All rights reserved.
//

import UIKit

class HXQLrcLabel: UILabel {

    public var progress: CGFloat = 0.0 {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        
        let fillRect = CGRect(x: 0, y: 0, width: self.bounds.size.width * self.progress , height: self.bounds.size.height)
        UIColor.green.set()
        UIRectFillUsingBlendMode(fillRect, .sourceIn)
    }

}
