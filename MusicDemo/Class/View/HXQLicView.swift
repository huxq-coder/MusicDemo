//
//  HXQLicView.swift
//  MusicDemo
//
//  Created by huxq-coder on 2020/7/22.
//  Copyright © 2020 huxq. All rights reserved.
//

import UIKit

/// 歌词显示view
class HXQLicView: UIScrollView, UITableViewDataSource {

    var licName: String!{
        didSet{
            licArray = HXQLicTool.licWithLicName(licName: licName)
            tableView.reloadData()
        }
    }
    
    var tableView: UITableView!
    var licArray: [HXQLicModel]!
    
    var currentIndex = 0
    
    
    var currentTime: TimeInterval!{
        didSet{
            for i in 0..<self.licArray.count {
                let licModel = self.licArray[i]
                let nextIndex = i + 1
                var nextLicModel = HXQLicModel()
                if nextIndex < self.licArray.count {
                    nextLicModel = self.licArray[nextIndex]
                }
                if i != self.currentIndex && currentTime >= licModel.time! && currentTime < nextLicModel.time! {
                    let currentIndexPath = IndexPath(row: i, section: 0)
                    self.currentIndex = i
                    self.tableView.scrollToRow(at: currentIndexPath, at: .top, animated: true)
                    
                }
            }
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTableView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }
    
    /// 设置tableview
    func setupTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        self.addSubview(tableView)
        tableView.rowHeight = 40
        tableView.separatorStyle = .none
    }
    
    override func layoutSubviews() {
        tableView.backgroundColor = UIColor.clear
        tableView.frame = CGRect(x: self.frame.size.width, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        tableView.backgroundColor = UIColor.clear
        tableView.contentInset = UIEdgeInsets(top: self.frame.size.height/2, left: 0, bottom: self.frame.size.height/2, right: 0)
    }
    
    
    // MARK: - tableview DataSource方法
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return licArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        cell?.selectionStyle = .none
        cell?.backgroundColor = UIColor.clear
        let model = licArray[indexPath.row]
        cell?.textLabel?.text = model.lic
        cell?.textLabel?.textAlignment = .center
        cell?.textLabel?.textColor = UIColor.white
        
        return cell!
    }

}
