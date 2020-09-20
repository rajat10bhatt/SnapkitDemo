//
//  ListRepository.swift
//  SnapkitDemo
//
//  Created by Rajat Bhatt on 20/09/20.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation
import RealmSwift

protocol ListRepositoryProtocol {
    func getItemList(completionError: @escaping ((String)->()))
}

class ListRepository: ListRepositoryProtocol {
    // MARK: Properties
    private var service: ListServiceProtocol
    
    
    // MARK: Init
    init(service: ListServiceProtocol) {
        self.service = service
    }
    
    // MARK: Get item list
    func getItemList(completionError: @escaping ((String)->())) {
        self.service.getItemsList(completionSuccess: { [weak self] (items) in
            self?.saveItems(items: items)
        }) { (error) in
            completionError(error)
        }
    }
    
    // Save items in realm
    private func saveItems(items: [Item]) {
        let realm = try? Realm()
        try? realm?.write {
            realm?.add(items, update: .modified)
        }
    }
}
