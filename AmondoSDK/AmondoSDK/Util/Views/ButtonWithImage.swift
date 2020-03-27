import UIKit

final class ButtonWithImage: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        if let _ = imageView {
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -7)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -3.5)
        }
    }
}
