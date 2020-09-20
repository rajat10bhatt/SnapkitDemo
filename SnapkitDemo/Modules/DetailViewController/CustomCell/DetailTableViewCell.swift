//
//  DetailTableViewCell.swift
//  SnapkitDemo
//
//  Created by Rajat Bhatt on 20/09/20.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    // MARK: Properties
    private let idLabel: UILabel = {
        let label = UILabel()
        let fontSize: CGFloat = isIpad ? 22 : 17
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .lightGray
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        let fontSize: CGFloat = isIpad ? 22 : 17
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .lightGray
        return label
    }()
    
    private let dataLabel: UILabel = {
        let label = UILabel()
        let fontSize: CGFloat = isIpad ? 22 : 17
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let dataImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalCentering
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
        self.dataImageView.image = nil
    }
    
    // MARK: SetupView
    private func setupView() {
        self.selectionStyle = .none
        self.stackView.addArrangedSubview(self.idLabel)
        self.stackView.addArrangedSubview(self.dataImageView)
        self.stackView.addArrangedSubview(self.dataLabel)
        self.stackView.addArrangedSubview(self.dateLabel)
        self.addSubview(self.stackView)
        self.stackView.snp.makeConstraints { (make) in
            let inset: CGFloat = isIpad ? 15 : 5
            make.edges.equalTo(self).inset(UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset))
        }
        self.dataImageView.snp.makeConstraints { (make) in
            let imageHeight: CGFloat = isIpad ? 700 : 400
            make.width.equalToSuperview()
            make.height.lessThanOrEqualTo(imageHeight)
        }
    }
    
    // MARK: Cell setup
    func setup(item: Item, itemType: ItemTypes) {
        self.dateLabel.text = item.date
        self.idLabel.text = "Id: \(item.id ?? String.empty)"
        switch itemType {
        case .image:
            self.dataLabel.isHidden = true
            self.dataImageView.isHidden = false
            if let imageUrl = URL(string: item.data ?? String.empty) {
                self.dataImageView.kf.setImage(with: imageUrl)
            }
        case .text, .other:
            self.dataLabel.text = item.data
            self.dataImageView.isHidden = true
            self.dataLabel.isHidden = false
        }
    }
}
