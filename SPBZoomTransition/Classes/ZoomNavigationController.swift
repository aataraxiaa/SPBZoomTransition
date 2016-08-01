//
//  ZoomNavigationController.swift
//  Pods
//
//  Created by Pete Smith on 31/07/2016.
//
//

import UIKit

class NavigationController: UINavigationController {
    
    private let zoomNavigationControllerDelegate = ZoomNavigationControllerDelegate()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        delegate = zoomNavigationControllerDelegate
    }
}
