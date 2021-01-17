//
//  MainCoordinator.swift
//  CV
//
//  Created by Krzysztof Kaczmarek on 17/01/2021.
//  Copyright © 2021 Kaczmarek. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: CoordinatorProtocol {
    var childCoordinators = [CoordinatorProtocol]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let repository = CVRepository()
        let viewModel = CV.ViewModel(repository: repository)
        let viewController = CV.ViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }
}
