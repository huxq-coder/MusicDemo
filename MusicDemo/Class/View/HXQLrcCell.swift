//
//  HXQLicCell.swift
//  MusicDemo
//
//  Created by evc_admin on 2020/7/29.
//  Copyright © 2020 huxq. All rights reserved.
//

import UIKit

class HXQLrcCell: UITableViewCell {

    public var lrcLabel: HXQLrcLabel?
    
    class func licCellWithTableView(tableView: UITableView) -> HXQLrcCell {
        let ID = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = HXQLrcCell(style: .default, reuseIdentifier: ID)
        }
        return cell as! HXQLrcCell
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let licLabel = HXQLrcLabel()
        licLabel.textColor = .white
        licLabel.textAlignment = .center
        licLabel.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(licLabel)
        self.lrcLabel = licLabel
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.lrcLabel!.frame = CGRect(x: 0, y: 0, width: self.contentView.bounds.size.width, height: self.contentView.bounds.size.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
