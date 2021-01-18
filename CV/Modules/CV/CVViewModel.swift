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
        case .didLoad, .didTapRetry:
            view?.update(with: CV.State(model: nil))
            fetchCVAndUpdateView()
        }
    }
    
    func fetchCVAndUpdateView() {
        repository.fetchCV { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.model = model
                self.view?.update(with: CV.State(model: model))
            case .failure(_):
                self.view?.update(with: CV.State(model: nil, alert: .errorWithRetry(message: "Couldn't load CV, try again.")))
            }
            
        }
    }
    
}
