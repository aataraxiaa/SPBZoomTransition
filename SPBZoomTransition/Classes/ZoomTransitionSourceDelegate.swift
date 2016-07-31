import UIKit

@objc public protocol ZoomTransitionSourceDelegate: NSObjectProtocol {

    func transitionSourceImageView() -> UIImageView
    func transitionSourceImageViewFrame(forward: Bool) -> CGRect
    @objc optional func transitionSourceWillBegin()
    @objc optional func transitionSourceDidEnd()
    @objc optional func transitionSourceDidCancel()
}
