//
//  TextTableViewCell.swift
//  SnapkitDemo
//
//  Created by Rajat Bhatt on 20/09/20.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit
import SnapKit

class TextTableViewCell: UITableViewCell {
    // MARK: Properties
    private let dataLabel: UILabel = {
        let label = UILabel()
        let fontSize: CGFloat = isIpad ? 22 : 17
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        let fontSize: CGFloat = isIpad ? 22 : 17
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .lightGray
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        let spacing: CGFloat = isIpad ? 15 : 10
        stackView.spacing = spacing
        return stackView
    }()
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Prepare for reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        self.dataLabel.text = nil
        self.dateLabel.text = nil
    }
    
    // MARK: SetupView
    private func setupView() {
        self.selectionStyle = .none
        self.stackView.addArrangedSubview(self.dataLabel)
        self.stackView.addArrangedSubview(self.dateLabel)
        self.addSubview(self.stackView)
        self.stackView.snp.makeConstraints { (make) in
            let inset: CGFloat = isIpad ? 15 : 5
            make.edges.equalTo(self).inset(UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset))
        }
    }
    
    // MARK: Cell setup
    func setup(item: Item) {
        self.dateLabel.text = item.date
        self.dataLabel.text = item.data
    }
}
