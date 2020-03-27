import UIKit

class AmondoTextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setActive() {

        UIView.animate(withDuration: activationAnimationDuration) { [weak self] in
            self?.tintColor = UIColor.Onboarding.textfieldTintActive
            self?.textColor = UIColor.Onboarding.textfieldTintActive
            self?.backgroundColor = UIColor.Onboarding.textfieldBackActive
        }
    }

    func setUnactive() {

        UIView.animate(withDuration: activationAnimationDuration) { [weak self] in
            self?.tintColor = UIColor.Onboarding.textfieldTintUnactive
            self?.textColor = UIColor.Onboarding.textfieldTintUnactive
            self?.backgroundColor = UIColor.Onboarding.textfieldBackUnactive
        }
    }

    private var activationAnimationDuration: TimeInterval = 0.25
}
