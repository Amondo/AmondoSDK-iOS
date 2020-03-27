import Foundation
import UIKit

final class NotificationService {

    static let animationYSpace: CGFloat = 200.0

    @discardableResult static func showNotification(
        view: UIView,
        text: String,
        emoji: String,
        backgroundColor: UIColor,
        textColor: UIColor,
        paddingConstant: CGFloat,
        padding: NotificationPadding = .top,
        time: TimeInterval? = .none) -> NotificationView {

        let xibViews = Bundle.main.loadNibNamed("NotificationView", owner: .none, options: .none)

        let notificationView = xibViews![0] as! NotificationView

        notificationView.setup(with: text, emoji: emoji, backgroundColor: backgroundColor, textColor: textColor)

        if let time = time {
            Timer.scheduledTimer(timeInterval: time, target: view, selector: Selector(("dismiss")), userInfo: .none, repeats: false)
        }

        let rootSuperview = view.rootSuperView
        let animationDuration: TimeInterval = 0.25

        let paddingConstraint: NSLayoutConstraint

        let superView = view.superview ?? view

        switch padding {
        case .top:
            paddingConstraint = NSLayoutConstraint(item: notificationView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: -paddingConstant)
        case .bottom:
            paddingConstraint = NSLayoutConstraint(item: notificationView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: paddingConstant)
        }

        let centerConstraint = NSLayoutConstraint(item: notificationView, attribute: .centerX, relatedBy: .equal, toItem: rootSuperview, attribute: .centerX, multiplier: 1.0, constant: 0.0)

        superView.addSubview(notificationView)

        notificationView.alpha = 0.0
        rootSuperview.addConstraint(centerConstraint)

        superView.addConstraint(paddingConstraint)
        view.layoutIfNeeded()

        UIView.animate(withDuration: animationDuration) {

            notificationView.frame.origin.y -= animationYSpace
            notificationView.alpha = 1.0
        }

        return notificationView
    }
}
