//
//  NewsFeedWorker.swift
//  VKNewsFeed
//
//  Created by Александр Цветков on 18.04.2020.
//  Copyright (c) 2020 Александр Цветков. All rights reserved.
//

import UIKit

class NewsFeedService {
    
    var authService: AuthService
    var networking: Networking
    var fetcher: DataFetcher
    private var revealedPostIds: Array<Int> = []
    private var feedResponse: FeedResponse?
    private var newFromInProcess: String?
    
    init() {
        self.authService = AppDelegate.shared().authService
        self.networking = NetworkService(authService: authService)
        self.fetcher = NetworkDataFetcher(networking: networking)
    }
    
    func getUser(completion: @escaping (UserResponse?) -> Void) {
        fetcher.getUser { (userResponse) in
            completion(userResponse)
        }
    }
    
    func getFeed(completion: @escaping (Array<Int>, FeedResponse) -> Void) {
        fetcher.getFeed(nextBatchFrom: nil) { [weak self] (feedResponse) in
            self?.feedResponse = feedResponse
            guard let feedResponse = self?.feedResponse else { return }
            completion(self!.revealedPostIds, feedResponse)
        }
    }
    
    func revealPostIds(forPostId postId: Int, completion: @escaping ([Int], FeedResponse) -> Void) {
        revealedPostIds.append(postId)
        guard let feedResponse = self.feedResponse else { return }
        completion(revealedPostIds, feedResponse)
    }
    
    func getNextBatch(completion: @escaping (Array<Int>, FeedResponse) -> Void) {
        newFromInProcess = feedResponse?.nextFrom
        fetcher.getFeed(nextBatchFrom: newFromInProcess) { [weak self] (feedResponse) in
            guard
                let feedResponse = feedResponse,
                let self = self,
                self.feedResponse?.nextFrom != feedResponse.nextFrom
                else { return }
            
            if self.feedResponse == nil {
                self.feedResponse = feedResponse
            } else {
                self.feedResponse?.items.append(contentsOf: feedResponse.items)
                var profiles = feedResponse.profiles
                if let oldProfiles = self.feedResponse?.profiles {
                    let oldProfilesFiltered = oldProfiles.filter { (oldProfile) -> Bool in
                        !feedResponse.profiles.contains { $0.id == oldProfile.id }
                    }
                    profiles.append(contentsOf: oldProfilesFiltered)
                }
                self.feedResponse?.profiles = profiles
                
                var groups = feedResponse.groups
                if let oldGroups = self.feedResponse?.groups {
                    let oldGroupsFiltered = oldGroups.filter { (oldGroup) -> Bool in
                        !feedResponse.groups.contains { $0.id == oldGroup.id }
                    }
                    groups.append(contentsOf: oldGroupsFiltered)
                }
                self.feedResponse?.groups = groups
                self.feedResponse?.nextFrom = feedResponse.nextFrom
            }
            
            guard let response = self.feedResponse else { return }
            completion(self.revealedPostIds, response)
        }
    }
}
