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
        private var currentState: State?
        
        private lazy var tableView: UITableView = {
            let tableView = UITableView(frame: CGRect.zero, style: .plain)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorColor = UIColor.white
            tableView.register(CVHeaderCell.self, forCellReuseIdentifier: "CVHeaderCell")
            tableView.register(CVProfileCell.self, forCellReuseIdentifier: "CVProfileCell")
            tableView.register(CVExperienceCell.self, forCellReuseIdentifier: "CVExperienceCell")
            tableView.register(CVEducationCell.self, forCellReuseIdentifier: "CVEducationCell")
            tableView.register(CVSkillCell.self, forCellReuseIdentifier: "CVSkillCell")
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

extension CV.ViewController: UITableViewDataSource, UITableViewDelegate {
    
    enum Section: Int, CaseIterable {
        case header = 0
        case profile
        case experience
        case education
        case skills
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionEnum = Section(rawValue: section), let state = currentState else { return 0 }
        let numberOfRows: Int
        switch sectionEnum {
        case .header:
            numberOfRows = 1
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
            if let profileCell = tableView.dequeueReusableCell(withIdentifier: "CVProfileCell", for: indexPath) as? CVProfileCell, let profile = currentState?.model?.profile {
                profileCell.configure(with: profile)
                cell = profileCell
            }
        case .experience:
            if let experienceCell = tableView.dequeueReusableCell(withIdentifier: "CVExperienceCell", for: indexPath) as? CVExperienceCell, let experience = currentState?.model?.experience {
                experienceCell.configure(with: experience[indexPath.row])
                cell = experienceCell
            }
        case .education:
            if let educationCell = tableView.dequeueReusableCell(withIdentifier: "CVEducationCell", for: indexPath) as? CVEducationCell, let education = currentState?.model?.education {
                educationCell.configure(with: education[indexPath.row])
                cell = educationCell
            }
        case .skills:
            if let skillCell = tableView.dequeueReusableCell(withIdentifier: "CVSkillCell", for: indexPath) as? CVSkillCell, let skills = currentState?.model?.skills {
                skillCell.configure(with: skills[indexPath.row])
                cell = skillCell
            }
        }
        
        
        return cell ?? UITableViewCell()
    }
    
}

private extension CV.ViewController {
    
    func render(state: CV.State) {
        currentState = state
        tableView.reloadData()
    }
    
    func setUp() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
    }
    
}
