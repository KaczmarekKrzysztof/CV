//
//  CVTitleWithDescriptionCell.swift
//  CV
//
//  Created by Krzysztof Kaczmarek on 17/01/2021.
//  Copyright © 2021 Kaczmarek. All rights reserved.
//

import Foundation
import UIKit

class CVTitleWithDescriptionCell: UITableViewCell, ConfigurableCellProtocol {
    typealias CellModelType = TitleWithDescriptionItem
    private lazy var containerView: UIView = prepareContainerView()
    private lazy var titleLabel: UILabel = prepareTitleLabel()
    private lazy var descriptionLabel: UILabel = prepareDescriptionLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with experience: TitleWithDescriptionItem) {
        titleLabel.text = experience.title
        descriptionLabel.text = experience.description
    }
    
}

private extension CVTitleWithDescriptionCell {
    
    func setUp() {
        selectionStyle = .none
        backgroundColor = .clear
        addSubviews()
        addConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
    }
    
    func addConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 18).isActive = true
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -18).isActive = true
        
        descriptionLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: 0).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 0).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
    }
    
    func prepareTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.font = UIFont.bold(withSize: 16)
        return label
    }
    
    func prepareDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.font = UIFont.regular(withSize: 14)
        return label
    }
    
    func prepareContainerView() -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.cellBackground()
        containerView.layer.cornerRadius = 8
        return containerView
    }
    
}
