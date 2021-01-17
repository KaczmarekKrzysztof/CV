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
    private lazy var nameLabel: UILabel = prepareNameLabel()
    private lazy var phoneNumberLabel: UILabel = preparePhoneNumberLabel()
    private lazy var emailLabel: UILabel = prepareEmailLabel()
    
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
        addSubviews()
        addConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(phoneNumberLabel)
        contentView.addSubview(emailLabel)
    }
    
    func addConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 18).isActive = true
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -18).isActive = true

        
        phoneNumberLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: 0).isActive = true
        phoneNumberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
        phoneNumberLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 0).isActive = true
        
        emailLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: 0).isActive = true
        emailLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 0).isActive = true
        emailLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 0).isActive = true
        emailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
    
    func prepareNameLabel() -> UILabel {
        let label = UILabel()
        return label
    }
    
    func preparePhoneNumberLabel() -> UILabel {
        let label = UILabel()
        return label
    }
    
    func prepareEmailLabel() -> UILabel {
        let label = UILabel()
        return label
    }
    
}
