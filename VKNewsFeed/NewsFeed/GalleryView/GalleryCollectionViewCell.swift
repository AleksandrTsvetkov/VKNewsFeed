//
//  GalleryCollectionViewCell.swift
//  VKNewsFeed
//
//  Created by Александр Цветков on 23.04.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    static let reuseId: String = "GalleryCollectionViewCell"
    let imageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    func set(imageUrl: String?) {
        imageView.set(imageURL: imageUrl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
