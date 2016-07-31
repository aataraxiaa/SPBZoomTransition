import UIKit

public final class ZoomInteractiveTransition: UIPercentDrivenInteractiveTransition {

    private var interactive = false

    var interactionController: ZoomInteractiveTransition? {
        return interactive ? self : nil
    }

    @objc func handlePanGestureRecognizer(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .changed:
            guard let view = recognizer.view else { return }
            let progress = recognizer.translation(in: view).x / view.bounds.width
            update(progress)
        case .cancelled, .ended:
            guard let view = recognizer.view else { return }
            let progress = recognizer.translation(in: view).x / view.bounds.width
            let velocity = recognizer.velocity(in: view).x
            if progress > 0.33 || velocity > 1000.0 {
                finish()
            } else {
                cancel()
            }
            interactive = false
        default:
            break
        }
    }
}


// MARK: - UIGestureRecognizerDelegate

extension ZoomInteractiveTransition: UIGestureRecognizerDelegate {

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        interactive = true
        return true
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer is UIScreenEdgePanGestureRecognizer
    }
}
