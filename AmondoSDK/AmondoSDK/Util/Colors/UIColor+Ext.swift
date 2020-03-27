import Foundation
import UIKit

extension UIColor {
    struct Onboarding {
        static var textfieldBackUnactive: UIColor {
            return UIColor.grayWith(value: 34.0)
        }

        static var textfieldBackActive: UIColor {
            return UIColor.white
        }

        static var textfieldTintUnactive: UIColor {
            return UIColor.white
        }

        static var textfieldTintActive: UIColor {
            return UIColor.grayWith(value: 17.0)
        }

        static var placeHolderColor: UIColor {
            return UIColor.grayWith(value: 152.0)
        }

        static var eyeTintColor: UIColor {
            return UIColor.grayWith(value: 195.0)
        }

        static var navigationTint: UIColor {
            return UIColor.grayWith(value: 85.0)
        }

        static var navigationBarTint: UIColor {
            return UIColor.black
        }

        static var navigationBarBorder: UIColor {
            return UIColor.grayWith(value: 34.0)
        }

        static var titlesColor: UIColor {
            return UIColor.white
        }

        static var explanationTextsColor: UIColor {
            return UIColor.grayWith(value: 195.0)
        }
    }

    struct Notification {
        static var negative: UIColor {
            return UIColor.colorFrom(red: 199.0, green: 31.0, blue: 78.0)
        }

        static var positive: UIColor {
            return UIColor.colorFrom(red: 42.0, green: 195.0, blue: 142.0)
        }
        
        static var info: UIColor {
            return UIColor.colorFrom(red: 255.0, green: 234.0, blue: 39.0)
        }

        static var negativeText: UIColor {
            return UIColor.white
        }

        static var positiveText: UIColor {
            return UIColor.white
        }
        
        static var infoText: UIColor {
            return UIColor.black
        }
    }

    struct Communication {
        static var activateColor: UIColor {
            return UIColor.colorFrom(red: 255.0, green: 234.0, blue: 39.0)
        }
    }

    static func colorFrom(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }

    static func grayWith(value: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: value / 255.0, green: value / 255.0, blue: value / 255.0, alpha: alpha)
    }
}
