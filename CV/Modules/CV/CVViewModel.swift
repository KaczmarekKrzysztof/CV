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
        private let repository: CVRepository
        private var model: CVModel?
        
        init(repository: CVRepository) {
            self.repository = repository
        }
        
        func sendAction(_ action: CV.Action) {
            process(action: action)
        }
        
    }
}

private extension CV.ViewModel {
    
    func process(action: CV.Action) {
        
        switch action {
        case .didLoad:
            view?.update(with: CV.State(model: nil))
            repository.fetchCV { [weak self] model in
                guard let self = self else { return }
                self.model = model
                self.view?.update(with: CV.State(model: model))
            }
        }
    }
    
}
