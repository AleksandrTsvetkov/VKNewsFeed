//
//  FeedViewController.swift
//  VKNewsFeed
//
//  Created by Александр Цветков on 15.04.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetcher.getFeed { (feedResponse) in
            guard let feedResponse = feedResponse else {
                print("No feed response in \(#function)")
                return
            }
            feedResponse.items.map { (feedItem) in
                print(feedItem.date)
            }
        }
        
    }
}
