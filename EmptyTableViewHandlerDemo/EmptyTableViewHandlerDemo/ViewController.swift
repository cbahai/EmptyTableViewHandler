//
//  ViewController.swift
//  EmptyData
//
//  Created by Chai on 2018/10/12.
//  Copyright © 2018年 FYH. All rights reserved.
//

import UIKit
import EmptyTableViewHandler

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var sectionHeaderView: UIView!
    @IBOutlet var sectionFooterView: UIView!
    @IBOutlet var emptyView: UIView!
    
    var emptyTableViewHandler: EmptyTableViewHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emptyTableViewHandler = EmptyTableViewHandler(tableView: self.tableView)
        self.emptyTableViewHandler.reloadData(with: self.emptyView)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.sectionHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.sectionHeaderView.bounds.height
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.sectionFooterView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.sectionFooterView.bounds.height
    }
}
