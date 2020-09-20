//
//  Item.swift
//  SnapkitDemo
//
//  Created by Rajat Bhatt on 20/09/20.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object, Codable {
    // MARK: Properties
    @objc dynamic var data: String?
    @objc dynamic var date: String?
    @objc dynamic var id: String?
    @objc dynamic var type: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: Equateble method
    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? Item else { return false }
        return object.id == self.id
    }
    
//    re init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        data = try values.decodeIfPresent(String.self, forKey: .data)
//        date = try values.decodeIfPresent(String.self, forKey: .date)
//        id = try values.decodeIfPresent(String.self, forKey: .id)
//        type = try values.decodeIfPresent(String.self, forKey: .type)
//    }
}
