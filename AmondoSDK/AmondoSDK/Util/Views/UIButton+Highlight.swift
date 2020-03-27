import Foundation
import UIKit

extension UIButton {
    override open var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.5 : 1.0
        }
    }
}
