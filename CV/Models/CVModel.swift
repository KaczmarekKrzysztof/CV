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
    let profile: Profile?
    let experience: [Experience]?
    let education: [Education]?
    let skills: [Skill]?
}

struct Header {
    let name: String
    let phoneNumber: String
    let email: String
}

struct Profile {
    let description: String
}

struct Experience {
    let title: String
    let description: String
}

struct Education {
    let description: String
}

struct Skill {
    let title: String
    let description: String
}
