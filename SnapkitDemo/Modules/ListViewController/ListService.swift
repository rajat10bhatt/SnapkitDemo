//
//  ListService.swift
//  SnapkitDemo
//
//  Created by Rajat Bhatt on 20/09/20.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation
import Alamofire

protocol ListServiceProtocol {
    func getItemsList(completionSuccess: @escaping (([Item])->()), completionError: @escaping ((String)->()))
}

class ListService: ListServiceProtocol {
    func getItemsList(completionSuccess: @escaping (([Item])->()), completionError: @escaping ((String)->())) {
        AF.request(AppUrls.listUrl).responseJSON { (response) in
            if response.error == nil {
                guard let data = response.data else {
                    completionError("Something went wrong")
                    return
                }
                do {
                    let items = try JSONDecoder().decode([Item].self, from: data)
                    completionSuccess(items)
                } catch {
                    completionError("Something went wrong")
                }
            } else {
                completionError("Something went wrong")
            }
        }
    }
}
