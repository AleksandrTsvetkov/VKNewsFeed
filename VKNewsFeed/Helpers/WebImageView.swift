//
//  WebImageView.swift
//  VKNewsFeed
//
//  Created by Александр Цветков on 19.04.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class WebImageView: UIImageView {
    
    func set(imageURL: String?) {
        guard
            let urlString = imageURL,
            let url = URL(string: urlString) else {
            print("Failed to create URL in \(#function)")
            return
        }
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponse.data)
            print("From cache")
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self.image = UIImage(data: data)
                    print("From internet")
                    self.handleLoadedImage(data: data, response: response)
                }
            }
        }
        dataTask.resume()
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else {
            print("Failed to get url from response in \(#function)")
            return
        }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    }
}
