//
//  NewsFeedCodeCell.swift
//  VKNewsFeed
//
//  Created by Александр Цветков on 21.04.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

protocol NewsFeedCodeCellDelegate: class {
    func revealPost(for cell: NewsFeedCodeCell)
}

final class NewsFeedCodeCell: UITableViewCell {
    
    static let reuseId = "NewsFeedCodeCell"
    weak var delegate: NewsFeedCodeCellDelegate?
    
    //MARK: FIRST LAYER
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        //view.backgroundColor = #colorLiteral(red: 0.5725490196, green: 0, blue: 0.231372549, alpha: 1)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: SECOND LAYER
    private let topView: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor(hex: "F4A88B")
        //view.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let postView: UITextView = {
        let textView = UITextView()
        textView.font = Constants.postLabelFont
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        let padding = textView.textContainer.lineFragmentPadding
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        textView.dataDetectorTypes = .all
        return textView
    }()
    
    private let moreTextButton: UIButton = {
        let button: UIButton = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(UIColor(hex: "669FD4"), for: .normal)
        //button.setTitleColor(#colorLiteral(red: 0.4, green: 0.6235294118, blue: 0.831372549, alpha: 1), for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("Показать полностью...", for: .normal)
        return button
    }()
    
    private let galleryCollectionView: GalleryCollectionView = GalleryCollectionView()
    
    private let postImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.backgroundColor = .darkGray
        return imageView
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor(hex: "F9D98C")
        //view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        return view
    }()
    
    //MARK: THIRD LAYER
    
    // TopView subviews
    private let iconImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.backgroundColor = UIColor(hex: "5D11F7")
        //imageView.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.textColor = UIColor(hex: "2C2D2E")
        //label.backgroundColor = UIColor(hex: "77C344")
        //label.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "818C99")
        //label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14)
        //label.backgroundColor = UIColor(hex: "42C1F7")
        //label.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        return label
    }()
    
    // BottomView subviews
    private let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = .white
        return view
    }()
    
    private let commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = .black
        return view
    }()
    
    private let sharesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = .white
        return view
    }()
    
    private let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = .white
        return view
    }()
    
    //MARK: FOURTH LAYER
    private let likesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "like")
        return imageView
    }()
    
    private let commentsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "comment")
        return imageView
    }()
    
    private let sharesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "share")
        return imageView
    }()
    
    private let viewsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "eye")
        return imageView
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "818C99")
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    private let commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "818C99")
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    private let sharesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "818C99")
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "818C99")
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    //MARK: FUNCTIONS
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        iconImageView.layer.cornerRadius = Constants.topViewHeight / 2
        iconImageView.clipsToBounds = true
        moreTextButton.addTarget(self, action: #selector(showMoreText), for: .touchUpInside)
        overlayFirstLayer()
        overlaySecondLayer()
        overlayThirdLayerOnTopView()
        overlayThirdLayerOnBottomView()
        overlayFourthLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        iconImageView.set(imageURL: nil)
        postImageView.set(imageURL: nil)
    }
    
    @objc func showMoreText() {
        delegate?.revealPost(for: self)
    }
    
    func set(viewModel: FeedCellViewModel) {
        iconImageView.set(imageURL: viewModel.iconUrlString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postView.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        postView.frame = viewModel.sizes.postLabelFrame
        bottomView.frame = viewModel.sizes.bottomViewFrame
        moreTextButton.frame = viewModel.sizes.moreTextButtonFrame
        
        if let photoAttachment = viewModel.photoAttachments.first, viewModel.photoAttachments.count == 1 {
            postImageView.set(imageURL: photoAttachment.photoUrlString)
            postImageView.isHidden = false
            galleryCollectionView.isHidden = true
            postImageView.frame = viewModel.sizes.attachmentFrame
        } else if viewModel.photoAttachments.count > 1 {
            galleryCollectionView.frame = viewModel.sizes.attachmentFrame
            postImageView.isHidden = true
            galleryCollectionView.isHidden = false
            galleryCollectionView.set(photos: viewModel.photoAttachments)
        } else {
            postImageView.isHidden = true
            galleryCollectionView.isHidden = true
        }
    }
    
    //MARK: WORK WITH LAYERS
    private func overlayFirstLayer() {
        addSubview(cardView)
        cardView.fillSuperview(padding: Constants.cardInsets)
    }
    
    private func overlaySecondLayer() {
        cardView.addSubview(topView)
        cardView.addSubview(postView)
        cardView.addSubview(moreTextButton)
        cardView.addSubview(postImageView)
        cardView.addSubview(galleryCollectionView)
        cardView.addSubview(bottomView)
        
        topView.anchor(top: cardView.topAnchor, leading: cardView.leadingAnchor, bottom: nil,
                       trailing: cardView.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 8, bottom: 999, right: 8))
        topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
    }
    
    private func overlayThirdLayerOnTopView() {
        topView.addSubview(iconImageView)
        topView.addSubview(nameLabel)
        topView.addSubview(dateLabel)
        
        iconImageView.anchor(top: topView.topAnchor, leading: topView.leadingAnchor, bottom: nil, trailing: nil)
        iconImageView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        
        nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 2).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: Constants.topViewHeight / 2).isActive = true
        
        dateLabel.anchor(top: nil, leading: iconImageView.trailingAnchor, bottom: topView.bottomAnchor, trailing: topView.trailingAnchor, padding: UIEdgeInsets(top: 999, left: 8, bottom: 2, right: 8))
    }
    
    private func overlayThirdLayerOnBottomView() {
        bottomView.addSubview(likesView)
        bottomView.addSubview(commentsView)
        bottomView.addSubview(sharesView)
        bottomView.addSubview(viewsView)
        
        likesView.anchor(top: bottomView.topAnchor, leading: bottomView.leadingAnchor, bottom: nil, trailing: nil, size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        commentsView.anchor(top: bottomView.topAnchor, leading: likesView.trailingAnchor, bottom: nil, trailing: nil, size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        sharesView.anchor(top: bottomView.topAnchor, leading: commentsView.trailingAnchor, bottom: nil, trailing: nil, size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        viewsView.anchor(top: bottomView.topAnchor,
                         leading: nil, bottom: nil,
                         trailing: bottomView.trailingAnchor,
                         padding: UIEdgeInsets(top: 0, left: 999, bottom: 999, right: 18) ,
                         size: CGSize(width: Constants.bottomViewViewWidth + 12, height: Constants.bottomViewViewHeight))
    }
    
    private func overlayFourthLayer() {
        likesView.addSubview(likesImage)
        likesView.addSubview(likesLabel)
        
        commentsView.addSubview(commentsImage)
        commentsView.addSubview(commentsLabel)
        
        sharesView.addSubview(sharesImage)
        sharesView.addSubview(sharesLabel)
        
        viewsView.addSubview(viewsImage)
        viewsView.addSubview(viewsLabel)
        
        anchorSubviews(view: likesView, imageView: likesImage, label: likesLabel)
        anchorSubviews(view: commentsView, imageView: commentsImage, label: commentsLabel)
        anchorSubviews(view: sharesView, imageView: sharesImage, label: sharesLabel)
        anchorSubviews(view: viewsView, imageView: viewsImage, label: viewsLabel)
    }
    
    private func anchorSubviews(view: UIView, imageView: UIImageView, label: UILabel) {
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize).isActive = true
        
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
