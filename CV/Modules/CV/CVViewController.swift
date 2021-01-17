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
        
        init(viewModel: CVViewModelProtocol) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
            self.viewModel.view = self
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func update(with state: CV.State) {
            render(state: state)
        }
        
    }
    
}

private extension CV.ViewController {
    
    func render(state: CV.State) {
        
    }
    
}
