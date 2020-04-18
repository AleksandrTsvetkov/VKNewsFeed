//
//  NetworkDataFetcher.swift
//  VKNewsFeed
//
//  Created by Александр Цветков on 17.04.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

protocol DataFetcher {
    func getFeed(response: @escaping (FeedResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getFeed(response: @escaping (FeedResponse?) -> Void) {
        let parameters = ["filters": "post, photo"]
        networking.request(path: API.newsFeed, parameters: parameters) { (data, error) in
            if let error = error {
                print("Received error in \(#function): \(error.localizedDescription)")
                response(nil)
            }
            guard let decoded = self.decodeJSON(type: FeedResponseWrapped.self, from: data) else {
                print("Failed to decode in \(#function)")
                response(nil)
                return
            }
            response(decoded.response)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard
            let data = data,
            let response = try? decoder.decode(type.self, from: data)
            else {
                print("Failed to decode JSON in \(#function)")
                return nil
        }
        return response
    }
    
}
