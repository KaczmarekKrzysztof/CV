//
//  CVViewController.swift
//  CV
//
//  Created by Krzysztof Kaczmarek on 17/01/2021.
//  Copyright © 2021 Kaczmarek. All rights reserved.
//

import Foundation
import UIKit

extension CV {
    
    class ViewController: UIViewController, CVViewProtocol {
        private let viewModel: CVViewModelProtocol
        private(set) var currentState: State?
        
        private let placeholderView: CVPlaceholderView = CVPlaceholderView()
        
        private lazy var tableView: UITableView = {
            let tableView = UITableView(frame: CGRect.zero, style: .grouped)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorColor = UIColor.background()
            tableView.backgroundColor = UIColor.background()
            tableView.register(CVHeaderCell.self, forCellReuseIdentifier: "CVHeaderCell")
            tableView.register(CVDescriptionCell.self, forCellReuseIdentifier: "CVDescriptionCell")
            tableView.register(CVTitleWithDescriptionCell.self, forCellReuseIdentifier: "CVTitleWithDescriptionCell")
            return tableView
        }()
        
        init(viewModel: CVViewModelProtocol) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
            self.viewModel.view = self
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setUp()
            viewModel.sendAction(.didLoad)
        }
        
        func update(with state: CV.State) {
            render(state: state)
        }
        
    }
    
}

private extension CV.ViewController {
    
    func render(state: CV.State) {
        currentState = state
        tableView.reloadData()
        let shouldShowPlaceholder: Bool = state.model == nil
        showPlaceholderIfNeeded(shouldShowPlaceholder)
        if case .errorWithRetry(let message) = state.alert {
            presentAlertWithMessage(message)
        }
    }
    
    func setUp() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor.background()
        view.addSubview(tableView)
        view.addSubview(placeholderView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        placeholderView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        
        placeholderView.topAnchor.constraint(equalTo: view.topAnchor, constant: 00).isActive = true
        placeholderView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        placeholderView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        placeholderView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
    }
    
    func showPlaceholderIfNeeded(_ shouldShowPlaceholder: Bool) {
        placeholderView.isHidden = !shouldShowPlaceholder
    }
    
    func presentAlertWithMessage(_ message: String) {
        let retryAction = UIAlertAction(title: "Retry", style: .default) { (_) in
            self.viewModel.sendAction(.didTapRetry)
        }
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(retryAction)
        present(alert, animated: true, completion: nil)
    }
}

extension CV.ViewController: UITableViewDataSource, UITableViewDelegate {
    
    enum Section: Int, CaseIterable {
        case header = 0
        case profile
        case experience
        case education
        case skills
        
        var title: String? {
            let title: String?
            switch self {
            case .header:
                title = nil
            case .profile:
                title = "Profile"
            case .experience:
                title = "Professional Experience"
            case .education:
                title = "Education"
            case .skills:
                title = "Skills"
            }
            return title
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionEnum = Section(rawValue: section), let state = currentState else { return 0 }
        let numberOfRows: Int
        switch sectionEnum {
        case .header:
            numberOfRows = state.model != nil ? 1 : 0
        case .profile:
            numberOfRows = state.model?.profile != nil ? 1 : 0
        case .experience:
            numberOfRows = state.model?.experience?.count ?? 0
        case .education:
            numberOfRows = state.model?.education?.count ?? 0
        case .skills:
            numberOfRows = state.model?.skills?.count ?? 0
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        var cell: UITableViewCell? = nil
        
        switch section {
        case .header:
            if let headerCell = tableView.dequeueReusableCell(withIdentifier: "CVHeaderCell", for: indexPath) as? CVHeaderCell, let header = currentState?.model?.header {
                headerCell.configure(with: header)
                cell = headerCell
            }
        case .profile:
            if let profileCell = tableView.dequeueReusableCell(withIdentifier: "CVDescriptionCell", for: indexPath) as? CVDescriptionCell, let profile = currentState?.model?.profile {
                profileCell.configure(with: profile)
                cell = profileCell
            }
        case .experience:
            if let experienceCell = tableView.dequeueReusableCell(withIdentifier: "CVTitleWithDescriptionCell", for: indexPath) as? CVTitleWithDescriptionCell, let experience = currentState?.model?.experience {
                experienceCell.configure(with: experience[indexPath.row])
                cell = experienceCell
            }
        case .education:
            if let educationCell = tableView.dequeueReusableCell(withIdentifier: "CVDescriptionCell", for: indexPath) as? CVDescriptionCell, let education = currentState?.model?.education {
                educationCell.configure(with: education[indexPath.row])
                cell = educationCell
            }
        case .skills:
            if let skillCell = tableView.dequeueReusableCell(withIdentifier: "CVTitleWithDescriptionCell", for: indexPath) as? CVTitleWithDescriptionCell, let skills = currentState?.model?.skills {
                skillCell.configure(with: skills[indexPath.row])
                cell = skillCell
            }
        }
        
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionEnum = Section(rawValue: section), let title = sectionEnum.title else { return nil }
        return CVHeaderView(title: title)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let sectionEnum = Section(rawValue: section), sectionEnum.title != nil else { return 0 }
        return 52
    }
    
}
