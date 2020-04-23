//
//  RowLayout.swift
//  VKNewsFeed
//
//  Created by Александр Цветков on 23.04.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

protocol RowLayoutDelegate: class {
    func collectionView(_ collectionView: UICollectionView, photoAt indexPath: IndexPath) -> CGSize
}

class RowLayout: UICollectionViewFlowLayout {
    
    weak var delegate: RowLayoutDelegate!
    static var numberOfRows: Int = 1
    fileprivate var cellPadding: CGFloat = 8
    fileprivate var cache: Array<UICollectionViewLayoutAttributes> = []
    fileprivate var contentWidth: CGFloat = 0
    
    fileprivate var contentHeight: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let insets: UIEdgeInsets = collectionView.contentInset
        return collectionView.bounds.height - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        contentWidth = 0
        cache = []
        guard cache.isEmpty, let collectionView = collectionView else { return }
        var photos: Array<CGSize> = []
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let photoSize = delegate.collectionView(collectionView, photoAt: indexPath)
            photos.append(photoSize)
        }
        let superViewWidth = collectionView.frame.width
        guard var rowHeight = RowLayout.calculateRowHeight(superViewWidth: superViewWidth, photosArray: photos) else { return }
        rowHeight = rowHeight / CGFloat(RowLayout.numberOfRows)
        let photosRatios: Array<CGFloat> = photos.map { $0.height / $0.width }
        var yOffset: Array<CGFloat> = []
        for row in 0 ..< RowLayout.numberOfRows {
            yOffset.append(CGFloat(row) * rowHeight)
        }
        var xOffset: Array<CGFloat> = Array(repeating: 0, count: RowLayout.numberOfRows)
        var row = 0
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let ratio = photosRatios[indexPath.row]
            let width = rowHeight / ratio
            let frame = CGRect(x: xOffset[row], y: yOffset[row], width: width, height: rowHeight)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = insetFrame
            cache.append(attribute)
            contentWidth = max(contentWidth, frame.maxX)
            xOffset[row] = xOffset[row] + width
            if row < (RowLayout.numberOfRows - 1) {
                row = row + 1
            } else {
                row = 0
            }
        }
    }
    
    static func calculateRowHeight(superViewWidth: CGFloat, photosArray: Array<CGSize>) -> CGFloat? {
        var rowHeight: CGFloat
        guard let photoWithMinRatio = photosArray.min (by: { (first, second) -> Bool in
            (first.height / first.width) < (second.height / second.width)
        }) else { return nil }
        let difference = superViewWidth / photoWithMinRatio.width
        rowHeight = photoWithMinRatio.height * difference
        rowHeight = rowHeight * CGFloat(RowLayout.numberOfRows)
        return rowHeight
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: Array<UICollectionViewLayoutAttributes> = []
        for attribute in cache {
            if attribute.frame.intersects(rect) {
                visibleLayoutAttributes.append(attribute)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.row]
    }
}
