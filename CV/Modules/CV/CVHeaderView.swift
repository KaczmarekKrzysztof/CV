//
//  CVHeaderView.swift
//  CV
//
//  Created by Krzysztof Kaczmarek on 17/01/2021.
//  Copyright © 2021 Kaczmarek. All rights reserved.
//

import Foundation
import UIKit

class CVHeaderView: UIView {
    private lazy var titleLabel: UILabel = prepareTitleLabel()
    private lazy var containerView: UIView = prepareContainerView()
    private let title: String
    
    init(title: String) {
        self.title = title
        super.init(frame: CGRect.zero)
        setUp()
        titleLabel.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension CVHeaderView {
    
    func prepareTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.bold(withSize: 22)
        return label
    }
    
    func prepareContainerView() -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.sectionHeader()
        containerView.layer.cornerRadius = 8
        return containerView
    }
    
    func setUp() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: -5).isActive = true
        containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
    }
}
