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
        let animationContainer = transitionContext.containerView()
        
        if let destinationView = transitionContext.view(forKey: UITransitionContextToViewKey), let sourceView = sourceDelegate?.sourceView(direction: transitionDirection), let destinationFrame = destinationDelegate?.destinationFrame(direction: transitionDirection) {
            
            let xScaleFactor = sourceView.frame.width/destinationFrame.width
            let yScaleFactor = sourceView.frame.height/destinationFrame.height
            
            let scaleTransForm = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
            
            animationContainer.addSubview(destinationView)
            animationContainer.bringSubview(toFront: destinationView)
            
            UIView.animate(withDuration: duration, animations: {
                sourceView.transform = scaleTransForm
            }, completion: { _ in })
        }
        
        switch transitionDirection {
        case .forward:
            transitionDirection = .back
        case .back:
            transitionDirection = .forward
        }
    }
}
