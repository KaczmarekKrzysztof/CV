//
//  Result.swift
//  CV
//
//  Created by Krzysztof Kaczmarek on 18/01/2021.
//  Copyright © 2021 Kaczmarek. All rights reserved.
//

import Foundation

enum Result<T: Any> {
    case success(value: T)
    case failure(error: Error)
}
