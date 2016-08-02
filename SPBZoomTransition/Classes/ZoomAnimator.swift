//
//  ZoomAnimator.swift
//  Pods
//
//  Created by Pete Smith on 01/08/2016.
//
//

import UIKit

public enum TransitionDirection {
    case forward
    case back
}

public protocol ZoomAnimatorDelegate {
    func transitionWillBegin(direction: TransitionDirection)
    func transitionDidEnd(direction: TransitionDirection)
}

public extension ZoomAnimatorDelegate {
    func transitionWillBegin(direction: TransitionDirection){}
    func transitionDidEnd(direction: TransitionDirection){}
}

public protocol ZoomAnimatorSourceDelegate: ZoomAnimatorDelegate {
    func sourceView(direction: TransitionDirection) -> UIView
}

public protocol ZoomAnimatorDestinationDelegate: ZoomAnimatorDelegate {
    func destinationFrame(direction: TransitionDirection) -> CGRect
}

final public class ZoomAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: Properties (Public)
    public var sourceDelegate: ZoomAnimatorSourceDelegate?
    public var destinationDelegate: ZoomAnimatorDestinationDelegate?
    
    // MARK: Properties (Private)
    private var duration = 1.0      // Default animation duration of 1 second
    private var presenting = true   // Default initial value of presenting or dismissing
    private var transitionDirection = TransitionDirection.forward   // Default initial transition direction
    
    convenience init(duration: Double) {
        self.init()
        
        self.duration = duration
    }

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let sourceView = sourceDelegate?.sourceView(direction: transitionDirection),
            let destinationView = transitionContext.view(forKey: UITransitionContextToViewKey), let destinationFrame = destinationDelegate?.destinationFrame(direction: transitionDirection) else {
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                return
        }
        
        let transitionContainer = transitionContext.containerView
        
        //transitionContainer.insertSubview(destinationView, belowSubview: sourceView)
        
        sourceDelegate?.transitionWillBegin(direction: transitionDirection)
        destinationDelegate?.transitionWillBegin(direction: transitionDirection)
        
        UIView.animate(
            withDuration: duration,
            delay: 0.0,
            options: .curveEaseOut,
            animations: {
                sourceView.frame = destinationFrame
            },
            completion: { _ in
                sourceView.removeFromSuperview()
                
                self.sourceDelegate?.transitionDidEnd(direction: self.transitionDirection)
                self.destinationDelegate?.transitionDidEnd(direction: self.transitionDirection)
                
                let completed = !transitionContext.transitionWasCancelled
                transitionContext.completeTransition(completed)
        })
        
        switch transitionDirection {
        case .forward:
            transitionDirection = .back
        case .back:
            transitionDirection = .forward
        }
    }
}
