//
//  HXQLicView.swift
//  MusicDemo
//
//  Created by huxq-coder on 2020/7/22.
//  Copyright © 2020 huxq. All rights reserved.
//

import UIKit

/// 歌词显示view
class HXQLrcView: UIScrollView, UITableViewDataSource {

    var lrcName: String!{
        didSet{
            // 切换歌曲，重置索引
            self.currentIndex = 0
            lrcArray = HXQLrcTool.licWithLicName(licName: lrcName)
            tableView.reloadData()
        }
    }
    
    var tableView: UITableView!
    var lrcArray: [HXQLrcModel]!
    
    var lrcLabel: HXQLrcLabel?
    
    var currentIndex = 0
    
    var duration: TimeInterval?
    
    var currentTime: TimeInterval!{
        didSet{
            for i in 0..<self.lrcArray.count-1 {
                let lrcModel = self.lrcArray[i]
                let nextIndex = i + 1
                var nextLicModel = HXQLrcModel()
                if nextIndex < self.lrcArray.count {
                    nextLicModel = self.lrcArray[nextIndex]
                }

                if i != self.currentIndex && currentTime >= lrcModel.time! && currentTime < nextLicModel.time! {
                    let currentIndexPath = IndexPath(row: i, section: 0)
                    let priorIndexPath = IndexPath(row: self.currentIndex, section: 0)

                    self.currentIndex = i
                    self.tableView.reloadRows(at: [currentIndexPath, priorIndexPath], with: .none)
                    self.tableView.scrollToRow(at: currentIndexPath, at: .top, animated: true)
                    self.lrcLabel?.text = lrcModel.lrc
                }
                if i == self.currentIndex && !lrcModel.lrc!.isEmpty {
                    let value = (currentTime - lrcModel.time!) / (nextLicModel.time! - lrcModel.time!)
                    let indexPath = IndexPath(row: self.currentIndex, section: 0)
                    
                    if let cell: HXQLrcCell = tableView.cellForRow(at: indexPath) as? HXQLrcCell {
                        cell.lrcLabel?.progress = CGFloat(value)
                        self.lrcLabel?.progress = CGFloat(value)
                    }
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
        tableView.rowHeight = 40
        self.addSubview(tableView)
    }
    
    override func layoutSubviews() {
        tableView.separatorStyle = .none
        tableView.frame = CGRect(x: self.frame.size.width, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        tableView.backgroundColor = UIColor.clear
        tableView.contentInset = UIEdgeInsets(top: self.frame.size.height/2, left: 0, bottom: self.frame.size.height/2, right: 0)
    }
    
    
    // MARK: - tableview DataSource方法
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lrcArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HXQLrcCell.licCellWithTableView(tableView: tableView)
        
        if self.currentIndex == indexPath.row {
            cell.lrcLabel?.font = UIFont.systemFont(ofSize: 20)
        } else {
            cell.lrcLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.lrcLabel?.progress = 0.0
        }
        let model = lrcArray[indexPath.row]
        cell.lrcLabel?.text = model.lrc
        return cell
    }

}
