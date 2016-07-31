//
//  LibraryCollectionLayout.swift
//  SpotPlayer
//
//  Created by Pete Smith on 01/05/2016.
//  Copyright © 2016 Pete Smith. All rights reserved.
//

import UIKit

class CollectionLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        
        minimumLineSpacing = 4.0
        minimumInteritemSpacing = 4.0
        
        scrollDirection = .vertical
    }
    
    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        
        let context = super.invalidationContext(forBoundsChange: newBounds)
        
        if let flowContext = context as? UICollectionViewFlowLayoutInvalidationContext {
            flowContext.invalidateFlowLayoutDelegateMetrics = true
        }
        
        return context
    }
}
