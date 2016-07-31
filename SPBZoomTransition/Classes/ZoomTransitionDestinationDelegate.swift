import UIKit

@objc public protocol ZoomTransitionDestinationDelegate: NSObjectProtocol {

    func transitionDestinationImageViewFrame(forward: Bool) -> CGRect
    @objc optional func transitionDestinationWillBegin()
    @objc optional func transitionDestinationDidEnd(transitioningImageView imageView: UIImageView)
    @objc optional func transitionDestinationDidCancel()
}
