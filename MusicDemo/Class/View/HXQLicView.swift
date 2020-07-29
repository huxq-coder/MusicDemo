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
            print(licArray.count)
            tableView.reloadData()
        }
    }
    
    var tableView: UITableView!
    var licArray: [HXQLicModel]!
    
    var currentIndex = 0
    
    var duration: TimeInterval?
    
    var currentTime: TimeInterval!{
        didSet{
            for i in 0..<self.licArray.count-1 {
                let licModel = self.licArray[i]
                let nextIndex = i + 1
                var nextLicModel = HXQLicModel()
                if nextIndex < self.licArray.count {
                    nextLicModel = self.licArray[nextIndex]
                }

                if i != self.currentIndex && currentTime >= licModel.time! && currentTime < nextLicModel.time! {
                    let currentIndexPath = IndexPath(row: i, section: 0)
                    let priorIndexPath = IndexPath(row: self.currentIndex, section: 0)

                    self.currentIndex = i
                    self.tableView.reloadRows(at: [currentIndexPath, priorIndexPath], with: .none)
                    self.tableView.scrollToRow(at: currentIndexPath, at: .top, animated: true)
                }
                if i == self.currentIndex && !licModel.lic!.isEmpty {
                    let value = (currentTime - licModel.time!) / (nextLicModel.time! - licModel.time!)
                    let indexPath = IndexPath(row: self.currentIndex, section: 0)
                    let cell = tableView.cellForRow(at: indexPath) as! HXQLicCell
                    cell.licLabel?.progress = CGFloat(value)
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
        return licArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HXQLicCell.licCellWithTableView(tableView: tableView)
        
        if self.currentIndex == indexPath.row {
            cell.licLabel?.font = UIFont.systemFont(ofSize: 20)
        } else {
            cell.licLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.licLabel?.progress = 0.0
        }
        let model = licArray[indexPath.row]
        cell.licLabel?.text = model.lic
        return cell
    }

}
