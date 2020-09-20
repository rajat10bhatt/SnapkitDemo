//
//  ImageTableViewCell.swift
//  SnapkitDemo
//
//  Created by Rajat Bhatt on 20/09/20.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit
import Kingfisher

class ImageTableViewCell: UITableViewCell {
    // MARK: Properties
    private let dataImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
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
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalCentering
        stackView.axis = .horizontal
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
        self.dataImageView.image = nil
        self.dateLabel.text = String.empty
    }
    
    // MARK: SetupView
    private func setupView() {
        self.selectionStyle = .none
        self.stackView.addArrangedSubview(self.dataImageView)
        self.stackView.addArrangedSubview(self.dateLabel)
        self.addSubview(self.stackView)
        self.dataImageView.snp.makeConstraints { (make) in
            let imageSize: CGFloat = isIpad ? 100 : 50
            make.size.equalTo(CGSize(width: imageSize, height: imageSize))
        }
        self.stackView.snp.makeConstraints { (make) in
            let inset: CGFloat = isIpad ? 15 : 5
            make.edges.equalTo(self).inset(UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset))
        }
    }
    
    // MARK: Setup cell
    func setup(item: Item) {
        self.dateLabel.text = item.date
        if let imageUrl = URL(string: item.data ?? String.empty) {
            self.dataImageView.kf.setImage(with: imageUrl)
        }
    }
}
