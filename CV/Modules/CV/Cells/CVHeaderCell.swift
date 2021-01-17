//
//  CVHeaderCell.swift
//  CV
//
//  Created by Krzysztof Kaczmarek on 17/01/2021.
//  Copyright © 2021 Kaczmarek. All rights reserved.
//

import Foundation
import UIKit

class CVHeaderCell: UITableViewCell, ConfigurableCellProtocol {
    typealias CellModelType = Header
    private lazy var containerView: UIView = prepareContainerView()
    private lazy var nameLabel: UILabel = prepareNameLabel()
    private lazy var phoneNumberLabel: UILabel = prepareRegularLabel()
    private lazy var emailLabel: UILabel = prepareRegularLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with header: Header) {
        nameLabel.text = header.name
        phoneNumberLabel.text = header.phoneNumber
        emailLabel.text = header.email
    }
    
}

private extension CVHeaderCell {
    
    func setUp() {
        selectionStyle = .none
        backgroundColor = UIColor.clear
        addSubviews()
        addConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(phoneNumberLabel)
        containerView.addSubview(emailLabel)
    }
    
    func addConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 18).isActive = true
        nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -18).isActive = true

        phoneNumberLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: 0).isActive = true
        phoneNumberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
        phoneNumberLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 0).isActive = true
        
        emailLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: 0).isActive = true
        emailLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 0).isActive = true
        emailLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 0).isActive = true
        emailLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
    }
    
    func prepareNameLabel() -> UILabel {
        let label = UILabel()
        label.textColor = UIColor.orange
        label.font = UIFont.bold(withSize: 24)
        return label
    }
    
    func prepareRegularLabel() -> UILabel {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.regular(withSize: 14)
        return label
    }
    
    func prepareContainerView() -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.cellBackground()
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 3
        containerView.layer.borderColor = UIColor.orange.cgColor
        return containerView
    }
    
}
