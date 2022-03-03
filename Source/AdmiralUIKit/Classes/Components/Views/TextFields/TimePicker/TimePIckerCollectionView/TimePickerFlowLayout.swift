//
//  TimePickerFlowLayout.swift
//  AdmiralUI
//
//  Created on 15.03.2021.
//

import UIKit

class TimePickerFlowLayout: UICollectionViewFlowLayout {
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = self.collectionView else {
            return CGPoint.zero
        }

        guard let itemsCount = collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: 0) else {
            return CGPoint.zero
        }
        
        switch scrollDirection {
        case .horizontal:
            let offsetX = updatedOffset(
                itemsCount: itemsCount,
                proposedContentOffset: proposedContentOffset.x,
                collectionViewSize: collectionView.frame.width,
                itemSize: itemSize.width,
                minimumLineSpacing: minimumLineSpacing)
            return CGPoint(x: offsetX, y: proposedContentOffset.y)
        case .vertical:
            let offsetY = updatedOffset(
                itemsCount: itemsCount,
                proposedContentOffset: proposedContentOffset.y,
                collectionViewSize: collectionView.frame.height,
                itemSize: itemSize.height,
                minimumLineSpacing: minimumLineSpacing)
            return CGPoint(x: proposedContentOffset.x, y: offsetY)
        default:
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
    }
    
    func updatedOffset(
        itemsCount: Int,
        proposedContentOffset: CGFloat,
        collectionViewSize: CGFloat,
        itemSize: CGFloat,
        minimumLineSpacing: CGFloat) -> CGFloat {
                
        let modifiedItemSize = itemSize + minimumLineSpacing
        let modifiedProposedContentOffset = proposedContentOffset + minimumLineSpacing / 2
        
        let offset = updatedOffset(
            itemsCount: itemsCount,
            proposedContentOffset: modifiedProposedContentOffset,
            collectionViewSize: collectionViewSize,
            itemSize: modifiedItemSize)
        
        return offset - minimumLineSpacing / 2
    }
    
    func updatedOffset(
        itemsCount: Int,
        proposedContentOffset: CGFloat,
        collectionViewSize: CGFloat,
        itemSize: CGFloat) -> CGFloat {
        guard itemSize != 0 else { return 0 }
                
        let centerPoint = proposedContentOffset + collectionViewSize / 2
        let numberOfItems = Int(centerPoint / itemSize)
        let itemPoint = CGFloat(numberOfItems) * itemSize
        let delta = (centerPoint - itemPoint) - itemSize / 2
        
        return proposedContentOffset - delta
    }
    
}
