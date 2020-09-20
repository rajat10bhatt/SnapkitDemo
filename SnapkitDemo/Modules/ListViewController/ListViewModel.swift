//
//  ListViewModel.swift
//  SnapkitDemo
//
//  Created by Rajat Bhatt on 20/09/20.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation
import RealmSwift

protocol ListViewModelInput {
    func getItemsList()
}

protocol ListViewModelOutput {
    var itemsCompletion: (()->())? { get set }
    var items: [Dictionary<String?, [Item]>.Element] { get }
}

protocol ListViewModelProtocol: ListViewModelInput, ListViewModelOutput {}

class ListViewModel: ListViewModelProtocol {
    // MARK: Properties
    private var repository: ListRepositoryProtocol
    private var notificationToken: NotificationToken?
    private (set) var items: [Dictionary<String?, [Item]>.Element] = [] {
        didSet {
            self.itemsCompletion?()
        }
    }
    var itemsCompletion: (()->())?
    
    // MARK: Init
    init(repository: ListRepositoryProtocol) {
        self.repository = repository
        self.observeItemUpdation()
    }
    
    deinit {
        self.notificationToken?.invalidate()
    }

    func getItemsList() {
        self.repository.getItemList { (error) in
            print(error)
        }
    }
    
    private func sortItems(items: [Item]) {
        let itemsWithData = items.filter { $0.data != nil }
        let groupedItems = Dictionary(grouping: itemsWithData) { $0.type }
        let sortedItems = groupedItems.sorted { ($0.key ?? String.empty) < ($1.key ?? String.empty) }
        self.items = sortedItems
    }
    
    private func observeItemUpdation() {
        let realm = try? Realm()
        let items = realm?.objects(Item.self)
        notificationToken = items?.observe({ (changes) in
            switch changes {
            case .initial(let items):
                self.sortItems(items: Array(items))
            case .update(let items, deletions: _, insertions: _, modifications: _):
                self.sortItems(items: Array(items))
            case .error(let error):
                print(error)
            }
        })
    }
}
