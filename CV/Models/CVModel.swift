//
//  CVModel.swift
//  CV
//
//  Created by Krzysztof Kaczmarek on 17/01/2021.
//  Copyright © 2021 Kaczmarek. All rights reserved.
//

import Foundation

struct CVModel {
    let header: Header
    let profile: DescriptionItem?
    let experience: [TitleWithDescriptionItem]?
    let education: [DescriptionItem]?
    let skills: [TitleWithDescriptionItem]?
}

struct Header {
    let name: String
    let phoneNumber: String
    let email: String
}

struct DescriptionItem {
    let description: String
}

struct TitleWithDescriptionItem {
    let title: String
    let description: String
}
