//
//  GalleryCollectionView.swift
//  VKNewsFeed
//
//  Created by Александр Цветков on 23.04.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class GalleryCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {
    
    var photos: Array<FeedCellPhotoAttachmentViewModel> = []
    
    init() {
        let rowLayout = RowLayout()
        super.init(frame: .zero, collectionViewLayout: rowLayout)
        delegate = self
        dataSource = self
        backgroundColor = .white
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseId)
        if let rowLayout = collectionViewLayout as? RowLayout {
            rowLayout.delegate = self
        }
    }
    
    func set(photos: Array<FeedCellPhotoAttachmentViewModel>) {
        self.photos = photos
        contentOffset = CGPoint.zero
        reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
}

extension GalleryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseId, for: indexPath) as! GalleryCollectionViewCell
        cell.set(imageUrl: photos[indexPath.row].photoUrlString)
        return cell
    }
}

extension GalleryCollectionView: RowLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, photoAt indexPath: IndexPath) -> CGSize {
        let width: Int = photos[indexPath.row].width
        let height: Int = photos[indexPath.row].height
        return CGSize(width: width, height: height)
    }
}
