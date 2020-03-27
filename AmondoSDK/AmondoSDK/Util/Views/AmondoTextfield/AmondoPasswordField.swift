import Foundation
import UIKit

final class AmondoPasswordField: AmondoTextField {
    var preferredFont: UIFont? {
        didSet {
            self.font = preferredFont

            if self.isSecureTextEntry {
                self.font = .none
            }
        }
    }

    override var isSecureTextEntry: Bool {
        didSet {
            if !isSecureTextEntry {
                self.font = .none
                self.font = preferredFont
            }
        }
    }

    private var passwordToggleVisibilityView: AmondoPasswordToggleVisibilityView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUI()
    }

    // MARK: - Prepare UI

    private func prepareUI() {
        let padding: CGFloat = 12.0
        let toggleFrame = CGRect(x: 0, y: 0, width: 24.0 + padding, height: frame.height)
        passwordToggleVisibilityView = AmondoPasswordToggleVisibilityView(frame: toggleFrame)
        passwordToggleVisibilityView.delegate = self

        passwordToggleVisibilityView.tintColor = UIColor.Onboarding.eyeTintColor
        self.keyboardType = .asciiCapable
        self.rightView = passwordToggleVisibilityView
        self.rightViewMode = .whileEditing

        self.font = self.preferredFont

        passwordToggleVisibilityView.eyeState = isSecureTextEntry ? .Closed : .Open
    }

    // MARK: - UITextFieldDelegate

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {

        let selectedRange = NSRange(location: range.location + string.count, length: 0)
        let from = textField.position(from: textField.beginningOfDocument, offset: selectedRange.location)!
        let to = textField.position(from: from, offset: selectedRange.length)!
        textField.selectedTextRange = textField.textRange(from: from, to: to)

        textField.sendActions(for: .editingChanged)

        return false
    }

    func textFieldDidEndEditing(textField: UITextField) {
        passwordToggleVisibilityView.eyeState = AmondoPasswordToggleVisibilityView.EyeState.Closed
        self.isSecureTextEntry = !isSelected
    }
}
