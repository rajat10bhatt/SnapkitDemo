//
//  BaseViewController.swift
//  SnapkitDemo
//
//  Created by Rajat Bhatt on 20/09/20.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    // MARK: Setup navigation
    func setupNavigationBar() {
        let navigationBar = navigationController!.navigationBar
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
}
