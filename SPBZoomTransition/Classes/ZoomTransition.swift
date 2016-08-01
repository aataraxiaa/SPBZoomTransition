//
//  ZoomTransitionDelegate.swift
//  Pods
//
//  Created by Pete Smith on 01/08/2016.
//
//

import UIKit

public final class ZoomTransition: NSObject, UIViewControllerTransitioningDelegate {
    
    // MARK: - Properties (Public)
    public var sourceDelegate: ZoomAnimatorSourceDelegate? {
        set {
            zoomAnimator.sourceDelegate = sourceDelegate
        }

        get {
            return zoomAnimator.sourceDelegate
        }
    }
    
    // MARK: - Properties (Private)
    private var zoomAnimator = ZoomAnimator()
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return zoomAnimator
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}
