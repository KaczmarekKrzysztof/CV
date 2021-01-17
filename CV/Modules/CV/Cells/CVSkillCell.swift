//
//  CVSkillCell.swift
//  CV
//
//  Created by Krzysztof Kaczmarek on 17/01/2021.
//  Copyright © 2021 Kaczmarek. All rights reserved.
//

import Foundation
import UIKit

class CVSkillCell: UITableViewCell, ConfigurableCellProtocol {
    typealias CellModelType = Skill
    private lazy var titleLabel: UILabel = prepareTitleLabel()
    private lazy var descriptionLabel: UILabel = prepareDescriptionLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with skill: Skill) {
        titleLabel.text = skill.title
        descriptionLabel.text = skill.description
    }
    
}

private extension CVSkillCell {
    
    func setUp() {
        selectionStyle = .none
        addSubviews()
        addConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    func addConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 18).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -18).isActive = true
        
        descriptionLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: 0).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 0).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
    
    func prepareTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }
    
    func prepareDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }
    
}
