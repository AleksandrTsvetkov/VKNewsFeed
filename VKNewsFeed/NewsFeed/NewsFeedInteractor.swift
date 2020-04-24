//
//  NewsFeedInteractor.swift
//  VKNewsFeed
//
//  Created by Александр Цветков on 18.04.2020.
//  Copyright (c) 2020 Александр Цветков. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
    func makeRequest(request: NewsFeed.Model.Request.RequestType)
} 

class NewsFeedInteractor: NewsFeedBusinessLogic {
    
    var presenter: NewsFeedPresentationLogic?
    var service: NewsFeedService?
    
    func makeRequest(request: NewsFeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsFeedService()
        }
        switch request {
        case .getNewsFeed:
            service?.getFeed { [weak self] (revealedPostIds, feedResponse) in
                self?.presenter?.presentData(response: .presentNewsFeed(feed: feedResponse, revealedPostIds: revealedPostIds))
            }
        case .revealPostIds(postId: let postId):
            service?.revealPostIds(forPostId: postId) {  [weak self]  (revealedPostIds, feedResponse) in
                self?.presenter?.presentData(response: .presentNewsFeed(feed: feedResponse, revealedPostIds: revealedPostIds))
            }
        case .getUser:
            service?.getUser(completion: { [weak self] (userResponse) in
                self?.presenter?.presentData(response: .presentUserInfo(userResponse: userResponse))
            })
        case .getNextBatch:
            self.presenter?.presentData(response: .presentFooterLoader)
            service?.getNextBatch(completion: { (revealedIds, feedResponse) in
                self.presenter?.presentData(response: .presentNewsFeed(feed: feedResponse, revealedPostIds: revealedIds))
            })
        }
    }
}
