//
//  FeedResponse.swift
//  VKNewsFeed
//
//  Created by Александр Цветков on 17.04.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

struct FeedResponseWrapped: Decodable {
    let response: FeedResponse
}

struct FeedResponse: Decodable {
    var items: [FeedItem]
}

struct FeedItem: Decodable {
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let comments: CountableItem?
    let likes: CountableItem?
    let reposts: CountableItem?
    let views: CountableItem?
}

struct CountableItem: Decodable {
    let count: Int
}
