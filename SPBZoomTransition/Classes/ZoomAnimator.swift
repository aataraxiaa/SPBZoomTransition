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
    func sourceImageView() -> UIImageView
    func sourceImageFrame() -> CGRect
}

public protocol ZoomAnimatorDestinationDelegate: ZoomAnimatorDelegate {
    func destinationFrame() -> CGRect
}

final public class ZoomAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: Properties (Public)
    public var sourceDelegate: ZoomAnimatorSourceDelegate?
    public var destinationDelegate: ZoomAnimatorDestinationDelegate?
    
    // MARK: Properties (Private)
    private var duration = 0.3      // Default animation duration of 1 second
    private var springVelocity: CGFloat = 0.0
    private var damping: CGFloat = 0.0
    private var presenting = true   // Default initial value of presenting or dismissing
    private var transitionDirection = TransitionDirection.forward   // Default initial transition direction
    
    public convenience init(duration: Double, damping: CGFloat, springVelocity: CGFloat) {
        self.init()
        
        self.duration = duration
        self.springVelocity = springVelocity
        self.damping = damping
    }

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // Get the source image view
        guard let sourceImageView = sourceDelegate?.sourceImageView(), let sourceImageFrame = sourceDelegate?.sourceImageFrame(), let destinationFrame = destinationDelegate?.destinationFrame() else {
            transitionContext.completeTransition(true)
            return
        }
        
        // Get the container view, destination view, and what might be the actual destination
        let containerView = transitionContext.containerView
        let destinationEntireView = transitionContext.view(forKey: UITransitionContextToViewKey)!
        let sourceEntireView = transitionContext.view(forKey: UITransitionContextFromViewKey)!
        let detailView = transitionDirection == .forward ? destinationEntireView : sourceEntireView
        
        // Create a copy of the source image view
        let sourceImageCopy = UIImageView(frame: sourceImageFrame)
        sourceImageCopy.image = sourceImageView.image?.copy() as? UIImage
        sourceEntireView.addSubview(sourceImageCopy)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: damping, initialSpringVelocity: springVelocity, options: .curveEaseIn, animations: {
            sourceImageCopy.frame = destinationFrame
        }, completion: {_ in
            containerView.addSubview(destinationEntireView)
            containerView.bringSubview(toFront: detailView)
        })
        
        
        // Always 'flip' the transition direction when we make a transition
        switch transitionDirection {
        case .forward:
            transitionDirection = .back
        case .back:
            transitionDirection = .forward
        }
    }
}
