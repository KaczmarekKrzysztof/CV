//
//  CVEducationCell.swift
//  CV
//
//  Created by Krzysztof Kaczmarek on 17/01/2021.
//  Copyright © 2021 Kaczmarek. All rights reserved.
//

import Foundation
import UIKit

class CVEducationCell: UITableViewCell, ConfigurableCellProtocol {
    typealias CellModelType = Education
    private lazy var descriptionLabel: UILabel = prepareDescriptionLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with education: Education) {
        descriptionLabel.text = education.description
    }
    
}

private extension CVEducationCell {
    
    func setUp() {
        selectionStyle = .none
        addSubviews()
        addConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(descriptionLabel)
    }
    
    func addConstraints() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 18).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -18).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
    
    func prepareDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }
    
}
