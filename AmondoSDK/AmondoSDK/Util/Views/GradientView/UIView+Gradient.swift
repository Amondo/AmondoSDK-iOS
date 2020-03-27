import Foundation
import UIKit

protocol GradientViewProvider {
    associatedtype GradientViewType
}

class GradientLayer: CAGradientLayer {
    var gradient: GradientType? {
        didSet {
            startPoint = gradient?.x ?? CGPoint.zero
            endPoint = gradient?.y ?? CGPoint.zero
        }
    }
}

class GradientView: UIView {
    override public class var layerClass: Swift.AnyClass {
        get {
            return GradientLayer.self
        }
    }
}

extension UIView: GradientViewProvider {
    typealias GradientViewType = GradientLayer
}

extension GradientViewProvider where Self: UIView {
    var gradientLayer: Self.GradientViewType {
        return layer as! Self.GradientViewType
    }
}
