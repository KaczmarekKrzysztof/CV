//
//  CVViewModel.swift
//  CV
//
//  Created by Krzysztof Kaczmarek on 17/01/2021.
//  Copyright © 2021 Kaczmarek. All rights reserved.
//

import Foundation

extension CV {
    
    class ViewModel: CVViewModelProtocol {
        weak var view: CVViewProtocol?
        
        func sendAction(_ action: CV.Action) {
            process(action: action)
        }
        
    }
}

private extension CV.ViewModel {
    
    func process(action: CV.Action) {
        
    }
    
}
