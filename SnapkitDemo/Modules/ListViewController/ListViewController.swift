//
//  ListViewController.swift
//  SnapkitDemo
//
//  Created by Rajat Bhatt on 20/09/20.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit
import SnapKit

class ListViewController: BaseViewController {
    // MARK: Properties
    private var viewModel: ListViewModelProtocol
    private lazy var tableView = UITableView()
    
    // MARK: Navigation controller life cycle methods
    init() {
        let repository = ListRepository(service: ListService())
        self.viewModel = ListViewModel(repository: repository)
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
        self.title = Viewtitles.listView.rawValue
        self.view.backgroundColor = .white
        self.observeItemsSuccess()
        self.setupTableView()
        self.viewModel.getItemsList()
    }
    
    // Setup tableview
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(TextTableViewCell.self, forCellReuseIdentifier: TextTableViewCell.reuseIdentifier)
        self.tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.reuseIdentifier)
        self.view.addSubview(tableView)
        self.tableView.separatorStyle = .none
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        }
    }
    
    // MARK: Observers
    // Items success observer
    private func observeItemsSuccess() {
        self.viewModel.itemsCompletion = {
            self.tableView.reloadData()
        }
    }
}

// MARK: Table view data source
extension ListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.items[section].value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let itemType = ItemTypes(rawValue: self.viewModel.items[indexPath.section].value[indexPath.row].type ?? String.empty) {
            switch itemType {
            case .image:
                let cell: ImageTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.setup(item: self.viewModel.items[indexPath.section].value[indexPath.row])
                return cell
            case .text, .other:
                let cell: TextTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.setup(item: self.viewModel.items[indexPath.section].value[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.viewModel.items[indexPath.section].value[indexPath.row]
        let itemType = ItemTypes(rawValue: item.type ?? String.empty) ?? ItemTypes.text
        let detailViewController = DetailViewController(item: item, itemType: itemType)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.items[section].key?.capitalized
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
