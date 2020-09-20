//
//  Constants.swift
//  SnapkitDemo
//
//  Created by Rajat Bhatt on 20/09/20.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

let isIpad = UIDevice.current.userInterfaceIdiom == .pad

enum Viewtitles: String {
    case listView = "Item List"
    case detail = "DetailView"
}

enum ItemTypes: String {
    case image
    case other
    case text
}
