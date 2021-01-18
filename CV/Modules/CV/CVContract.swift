//
//  CVContract.swift
//  CV
//
//  Created by Krzysztof Kaczmarek on 17/01/2021.
//  Copyright © 2021 Kaczmarek. All rights reserved.
//

import Foundation

struct CV {}

extension CV {
    
    enum Action {
        case didLoad
        case didTapRetry
    }
    
}

extension CV {
    
    struct State {
        let model: CVModel?
        let alert: Alert
        
        init(model: CVModel?, alert: Alert = .none) {
            self.model = model
            self.alert = alert
        }
    }
    
}

extension CV {
    
    enum Alert {
        case none
        case errorWithRetry(message: String)
    }
}

protocol CVViewProtocol: class {
    var currentState: CV.State? { get }
    func update(with state: CV.State)
}

protocol CVViewModelProtocol: class {
    var view: CVViewProtocol? { get set }
    func sendAction(_ action: CV.Action)
}
