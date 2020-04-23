//
//  UserResponse.swift
//  VKNewsFeed
//
//  Created by Александр Цветков on 23.04.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import Foundation

struct UserResponseWrapped: Decodable {
    let response: Array<UserResponse>
}

struct UserResponse: Decodable {
    let photo100: String?
}
