//
//  NetworkDataFetcher.swift
//  VKNewsFeed
//
//  Created by Александр Цветков on 17.04.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

protocol DataFetcher {
    func getFeed(nextBatchFrom: String?, response: @escaping (FeedResponse?) -> Void)
    func getUser(response: @escaping (UserResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    
    private let authService: AuthService
    let networking: Networking
    
    init(networking: Networking, authService: AuthService = AppDelegate.shared().authService) {
        self.networking = networking
        self.authService = authService
    }
    
    func getUser(response: @escaping (UserResponse?) -> Void) {
        guard let userId = authService.userId else {
            print("Failed to get userId in \(#function)")
            return
        }
        let parameters = ["user_ids": userId, "fields" : "photo_100"]
        networking.request(path: API.user, parameters: parameters) { (data, error) in
            if let error = error {
                print("Received error in \(#function): \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(type: UserResponseWrapped.self, from: data)
            response(decoded?.response.first)
        }
    }
    
    func getFeed(nextBatchFrom: String?, response: @escaping (FeedResponse?) -> Void) {
        var parameters = ["filters": "post, photo"]
        parameters["start_from"] = nextBatchFrom
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
