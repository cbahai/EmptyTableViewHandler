//
//  EmptyTableViewHandler.swift
//  EmptyTableViewHandler
//
//  Created by Chai on 2018/10/12.
//  Copyright © 2018年 FYH. All rights reserved.
//

import UIKit

public class EmptyTableViewHandler: NSObject {
    
    public weak var sectionHeaderView: UIView?
    public weak var sectionFooterView: UIView?
    
    private weak var tableViewDataSource: UITableViewDataSource?
    private weak var tableViewDelegate: UITableViewDelegate?
    private weak var tableView: UITableView!
    private var emptyView = UIView()
    
    @objc
    public init(tableView: UITableView) {
        super.init()
        self.tableViewDataSource = tableView.dataSource
        self.tableViewDelegate = tableView.delegate
        self.tableView = tableView
    }
    
    @objc
    public func reloadData(with emptyView: UIView) {
        self._reloadData(with: emptyView, isJudgeEmpty: nil)
    }
    
    @objc
    public func reloadData(with emptyView: UIView, isJudgeEmpty: Bool) {
        self._reloadData(with: emptyView, isJudgeEmpty: isJudgeEmpty)
    }
    
    private func _reloadData(with emptyView: UIView, isJudgeEmpty: Bool? = nil) {
        self.emptyView = emptyView
        
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
    
    private func addEmptyView(to cell: UITableViewCell) {
        if let emptyViewSuperview = self.emptyView.superview, emptyViewSuperview === cell.contentView {
            return
        }
        
        cell.contentView.addSubview(self.emptyView)
        self.emptyView.translatesAutoresizingMaskIntoConstraints = false
        let views: [String: Any] = ["view": self.emptyView]
        cell.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        cell.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
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
        let identifier = "*^$^EmptyTableViewCell^&^*"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ?? UITableViewCell(style: .default, reuseIdentifier: identifier)
        self.addEmptyView(to: cell)
        return cell
    }
}

extension EmptyTableViewHandler: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let residueHeight = tableView.bounds.height - (tableView.tableHeaderView?.bounds.height ?? 0) - (tableView.tableFooterView?.bounds.height ?? 0)
        if residueHeight < self.emptyView.bounds.height {
            return self.emptyView.bounds.height
        }
        return residueHeight
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let sectionHeaderView = self.sectionHeaderView {
            return sectionHeaderView.bounds.height
        }
        return self.tableViewDelegate?.tableView?(tableView, heightForHeaderInSection: section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if let sectionFooterView = self.sectionFooterView {
            return sectionFooterView.bounds.height
        }
        return self.tableViewDelegate?.tableView?(tableView, heightForFooterInSection: section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let sectionHeaderView = self.sectionHeaderView {
            return sectionHeaderView
        }
        return self.tableViewDelegate?.tableView?(tableView, viewForHeaderInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let sectionFooterView = self.sectionFooterView {
            return sectionFooterView
        }
        return self.tableViewDelegate?.tableView?(tableView, viewForFooterInSection: section)
    }
}
