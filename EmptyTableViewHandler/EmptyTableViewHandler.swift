//
//  EmptyTableViewHandler.swift
//  EmptyTableViewHandler
//
//  Created by Chai on 2018/10/12.
//  Copyright © 2018年 FYH. All rights reserved.
//

import UIKit

public class EmptyTableViewHandler: NSObject {
    
    private weak var tableViewDataSource: UITableViewDataSource?
    private weak var tableViewDelegate: UITableViewDelegate?
    private weak var tableView: UITableView!
    private var emptyCell = UITableViewCell(style: .default, reuseIdentifier: nil)
    
    public init(handle tableView: UITableView) {
        super.init()
        self.tableViewDataSource = tableView.dataSource
        self.tableViewDelegate = tableView.delegate
        self.tableView = tableView
    }
    
    public func reloadData(with emptyCell: UITableViewCell, isJudgeEmpty: Bool? = nil) {
        self.emptyCell = emptyCell
        
        let isEmpty: Bool
        
        if let isJudgeEmpty = isJudgeEmpty {
            isEmpty = isJudgeEmpty
        } else {
            var count: Int = 0
            if let tableViewDataSource = self.tableViewDataSource {
                let numberOfSections = tableViewDataSource.numberOfSections?(in: self.tableView) ?? 1
                for s in 0..<numberOfSections {
                    count += tableViewDataSource.tableView(self.tableView, numberOfRowsInSection: s)
                }
            }
            isEmpty = count < 1
        }
        
        if isEmpty {
            self.tableView.dataSource = self
            self.tableView.delegate = self
        } else {
            self.tableView.dataSource = self.tableViewDataSource
            self.tableView.delegate = self.tableViewDelegate
        }
        
        self.tableView.reloadData()
    }
}

extension EmptyTableViewHandler: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.emptyCell
    }
}

extension EmptyTableViewHandler: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let residueHeight = tableView.bounds.height - (tableView.tableHeaderView?.bounds.height ?? 0) - (tableView.tableFooterView?.bounds.height ?? 0)
        if residueHeight < self.emptyCell.bounds.height {
            return self.emptyCell.bounds.height
        }
        return residueHeight
    }
}
