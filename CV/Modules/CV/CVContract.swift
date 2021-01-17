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
    }
    
}

extension CV {
    
    struct State {
        
    }
    
}

protocol CVViewProtocol: class {
    func update(with state: CV.State)
}

protocol CVViewModelProtocol: class {
    func sendAction(_ action: CV.Action)
}
