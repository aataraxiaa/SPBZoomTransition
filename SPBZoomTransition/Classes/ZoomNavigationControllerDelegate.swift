import UIKit

public final class ZoomNavigationControllerDelegate: NSObject {

    private let zoomInteractiveTransition = ZoomInteractiveTransition()
}


// MARK: - UINavigationControllerDelegate

extension ZoomNavigationControllerDelegate: UINavigationControllerDelegate {

    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {

        if let gestureRecognizer = navigationController.interactivePopGestureRecognizer, gestureRecognizer.delegate !== zoomInteractiveTransition {
            gestureRecognizer.delegate = zoomInteractiveTransition
            gestureRecognizer.addTarget(zoomInteractiveTransition, action: #selector(ZoomInteractiveTransition.handlePanGestureRecognizer(_:)))
        }

        return zoomInteractiveTransition.interactionController
    }

    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        if let source = fromVC as? ZoomTransitionSourceDelegate, let destination = toVC as? ZoomTransitionDestinationDelegate, operation == .push {
            return ZoomTransition(source: source, destination: destination, forward: true)
        } else if let source = toVC as? ZoomTransitionSourceDelegate, let destination = fromVC as? ZoomTransitionDestinationDelegate, operation == .pop {
            return ZoomTransition(source: source, destination: destination, forward: false)
        }
        return nil
    }
}
