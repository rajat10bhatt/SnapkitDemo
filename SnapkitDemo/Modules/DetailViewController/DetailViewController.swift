//
//  DetailViewController.swift
//  SnapkitDemo
//
//  Created by Rajat Bhatt on 20/09/20.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {
    // MARK: Properties
    private var item: Item
    private var itemType: ItemTypes
    private lazy var tableView = UITableView()
    
    // MARK: Navigation controller life cycle methods
    init(item: Item, itemType: ItemTypes) {
        self.item = item
        self.itemType = itemType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initalizeView()
    }
    
    // MARK: Customs methods
    // Initailize view
    private func initalizeView() {
        self.setupNavigationBar()
        self.title = Viewtitles.detail.rawValue
        self.view.backgroundColor = .white
        self.setupTableView()
    }
    
    // Setup tableview
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.reuseIdentifier)
        self.view.addSubview(tableView)
        self.tableView.separatorStyle = .none
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        }
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DetailTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.setup(item: item, itemType: itemType)
        return cell
    }
}
