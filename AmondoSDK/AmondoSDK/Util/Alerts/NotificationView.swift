import Foundation
import UIKit

//temp location
func showAlert(title: String?, message: String?, buttonTitle: String, sender: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))
    sender.present(alert, animated: true, completion: nil)
}

final class NotificationView: UIView {

    @IBOutlet private weak var labelEmoji: UILabel!
    @IBOutlet private weak var labelNotification: UILabel!
    
    var dismissable: Bool = true

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetup()
    }

    // MARK: -

    func setup(with text: String, emoji: String, backgroundColor: UIColor = .red, textColor: UIColor = .black) {
        labelNotification.text = text.firstCapitalized
        labelEmoji.text = emoji
        self.backgroundColor = backgroundColor
        labelNotification.textColor = textColor
    }

    @objc func dismiss(animated: Bool = true) {
        if !dismissable {
            return
        }
        DispatchQueue.main.async {
            if animated {
                UIView.animate(withDuration: NotificationView.animationDuration, animations: {

                    self.frame.origin.y += NotificationService.animationYSpace
                    self.alpha = 0.0
                }) { _ in
                    self.removeFromSuperview()
                }
            } else {
                self.removeFromSuperview()
            }
        }
    }

    @objc func tapOnView() {
        if #available(iOS 10.0, *) {
            let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
            feedbackGenerator.prepare()
            feedbackGenerator.impactOccurred()
        }

        dismiss()
    }

    // MARK: - Private

    private func initialSetup() {
        addConstraints()
        addTapGesture()
    }

    private static let animationDuration: TimeInterval = 0.25

    private func addTapGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapOnView))
        addGestureRecognizer(gesture)
    }

    private var widthConstant: CGFloat {
        return UIScreen.main.bounds.width - 40.0
    }

    private func addConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        let widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1.0, constant: widthConstant)

        self.addConstraint(widthConstraint)
    }
}
