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
        
        func update(with state: CV.State) {
            render(state: state)
        }
        
    }
    
}

private extension CV.ViewController {
    
    func render(state: CV.State) {
        
    }
    
}
