//
//  NetworkService.swift
//  VKNewsFeed
//
//  Created by Александр Цветков on 15.04.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import Foundation

final class NetworkService {
    
    //https://api.vk.com/method/users.get?user_ids=210700286&fields=bdate&access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3&v=5.103
    
    private let authService: AuthService
    
    init(authService: AuthService = AppDelegate.shared().authService) {
        self.authService = authService
    }
    
    func getFeed() {
        guard let token = authService.token else {
            print("Token is nil in \(#function)")
            return
        }
        let parameters = ["filters": "post,photo"]
        var allParameters = parameters
        allParameters["access_token"] = token
        allParameters["v"] = API.version
        
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.newsFeed
        components.queryItems = allParameters.map { URLQueryItem(name: $0, value: $1) }
        
        let url = components.url!
        print(url)
    }
}
