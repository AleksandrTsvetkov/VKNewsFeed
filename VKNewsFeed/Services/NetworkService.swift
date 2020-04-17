//
//  NetworkService.swift
//  VKNewsFeed
//
//  Created by Александр Цветков on 15.04.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import Foundation

protocol Networking {
    func request(path: String, parameters: [String: String], completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkService: Networking {
    
    
    //https://api.vk.com/method/users.get?user_ids=210700286&fields=bdate&access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3&v=5.103
    
    private let authService: AuthService
    
    init(authService: AuthService = AppDelegate.shared().authService) {
        self.authService = authService
    }
    
    func request(path: String, parameters: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        guard let token = authService.token else {
            print("Token is nil in \(#function)")
            return
        }
        let parameters = ["filters": "post,photo"]
        var allParameters = parameters
        allParameters["access_token"] = token
        allParameters["v"] = API.version
        let url = self.url(from: path, parameters: allParameters)
        let urlRequest = URLRequest(url: url)
        let task = createDataTask(from: urlRequest, completion: completion)
        task.resume()
        print(url)
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        let session = URLSession.init(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        return task
    }
    
    private func url(from path: String, parameters: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.newsFeed
        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        
        return components.url!
    }
}
