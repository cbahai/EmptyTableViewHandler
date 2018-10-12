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
    
    var emptyTableViewHandler: EmptyTableViewHandler!
    
    var emptyCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let emptyCell = UITableViewCell(style: .default, reuseIdentifier: nil)
        emptyCell.contentView.backgroundColor = UIColor.yellow
        
        self.emptyTableViewHandler = EmptyTableViewHandler(handle: self.tableView)
        self.emptyTableViewHandler.reloadData(with: emptyCell)
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
