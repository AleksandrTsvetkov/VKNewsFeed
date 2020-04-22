//
//  NewsFeedLayoutCalculator.swift
//  VKNewsFeed
//
//  Created by Александр Цветков on 20.04.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

struct Sizes: FeedCellSizes {
    var postLabelFrame: CGRect
    var attachmentFrame: CGRect
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
    var moreTextButtonFrame: CGRect
}

struct Constants {
    static let cardInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
    static let topViewHeight: CGFloat = 50
    static let postLabelInsets: UIEdgeInsets = UIEdgeInsets(top: 8 + Constants.topViewHeight + 8, left: 8, bottom: 8, right: 8)
    static let postLabelFont: UIFont = UIFont.systemFont(ofSize: 15)
    static let bottomViewHeight: CGFloat = 44
    static let bottomViewViewHeight: CGFloat = 44
    static let bottomViewViewWidth: CGFloat = 66
    static let bottomViewViewsIconSize: CGFloat = 24
    static let lineLimitInPost: CGFloat = 8
    static let visibleLinesAmount: CGFloat = 6
    static let moreTextButtonInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    static let moreTextButtonSize: CGSize = CGSize(width: 170, height: 30)
}

protocol NewsFeedLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSizedPost: Bool) -> FeedCellSizes
}

final class NewsFeedLayoutCalculator: NewsFeedLayoutCalculatorProtocol {
    
    private let screenWidth: CGFloat
    
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSizedPost: Bool) -> FeedCellSizes {
        
        var showMoreTextButton = false
        
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        var postLabelFrame: CGRect = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top), size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let width: CGFloat = cardViewWidth - Constants.postLabelInsets.left - Constants.cardInsets.right
            var height: CGFloat = text.height(width: width, font: Constants.postLabelFont)
            let limitHeight = Constants.postLabelFont.lineHeight * Constants.lineLimitInPost
            if height > limitHeight, !isFullSizedPost {
                height = Constants.postLabelFont.lineHeight * Constants.visibleLinesAmount
                showMoreTextButton = true
            }
            postLabelFrame.size = CGSize(width: width, height: height)
            
        }
        
        var moreTextButtonSize = CGSize.zero
        if showMoreTextButton {
            moreTextButtonSize = Constants.moreTextButtonSize
        }
        let moreTextButtonOrigin: CGPoint = CGPoint(x: Constants.moreTextButtonInsets.left, y: postLabelFrame.maxY)
        let moreTextButtonFrame: CGRect = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)
    
        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInsets.top : moreTextButtonFrame.maxY + Constants.postLabelInsets.bottom
        
        var attachmentFrame: CGRect = CGRect(origin: CGPoint(x: 0, y: attachmentTop), size: CGSize.zero)
        
        if let attachment = photoAttachments.first {
            let photoHeight: Float = Float(attachment.height)
            let photoWidth: Float = Float(attachment.width)
            let ratio = CGFloat(photoHeight / photoWidth)
            if photoAttachments.count == 1 {
                attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
            } else if photoAttachments.count > 1 {
                attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
            }
        }
        let bottomViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY)
        
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop), size: CGSize(width: cardViewWidth, height: Constants.bottomViewHeight))
        let totalHeight = bottomViewFrame.maxY + Constants.cardInsets.bottom
        return Sizes(postLabelFrame: postLabelFrame,
                     attachmentFrame: attachmentFrame,
                     bottomViewFrame: bottomViewFrame,
                     totalHeight: totalHeight,
                     moreTextButtonFrame: moreTextButtonFrame)
    }
}
