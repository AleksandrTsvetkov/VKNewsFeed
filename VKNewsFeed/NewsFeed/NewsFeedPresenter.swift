//
//  NewsFeedPresenter.swift
//  VKNewsFeed
//
//  Created by Александр Цветков on 18.04.2020.
//  Copyright (c) 2020 Александр Цветков. All rights reserved.
//

import UIKit

protocol NewsFeedPresentationLogic {
    func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
    weak var viewController: NewsFeedDisplayLogic?
    
    func presentData(response: NewsFeed.Model.Response.ResponseType) {
        switch response {
            
        case .some:
            print(".some Presenter")
        case .presentNewsFeed:
            print(".presentNewsFeed Interactor")
        }
        viewController?.displayData(viewModel: .displayNewsFeed)
    }
}
