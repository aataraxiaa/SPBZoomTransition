import UIKit

extension UIImageView {

    convenience init(baseImageView: UIImageView, frame: CGRect) {
        self.init(frame: CGRect.zero)

        image = baseImageView.image
        contentMode = baseImageView.contentMode
        clipsToBounds = true
        self.frame = frame
    }
}
