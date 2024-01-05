//
//  FavoritesCarouselFlowLayout.swift
//  NewsApp
//
//  Created by Alexandra Boar on 04.01.2024.
//

import Foundation
import UIKit

class FavoritesCarouselFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        sectionInset = .init(top: 0.0, left: 0.0, bottom: 0.0, right: 20.0)
        scrollDirection = .horizontal
        itemSize = CGSize(width: Constants.favoritesCellWidth, height: Constants.favoritesCellHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard UIDevice.current.userInterfaceIdiom != .pad else { return proposedContentOffset }
        guard let collectionView = collectionView else { return proposedContentOffset }
        
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
        let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        
        // Retrieve the layout attributes for all of the cells in the target rectangle.
        guard let attributesList = super.layoutAttributesForElements(in: targetRect) else { return proposedContentOffset }
        for attributes in attributesList {
            // Find the nearest attributes to the center of collectionView.
            if abs(attributes.center.x - horizontalCenter) < abs(offsetAdjustment) {
                offsetAdjustment = attributes.center.x - horizontalCenter
            }
        }
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
    
}
