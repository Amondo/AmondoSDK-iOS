import Foundation
import UIKit

extension AmondoPasswordField: PasswordToggleVisibilityDelegate {
    func viewWasToggled(passwordToggleVisibilityView: AmondoPasswordToggleVisibilityView, isSelected selected: Bool) {

        let string = self.text
        self.text = " "
        self.text = string

        self.isSecureTextEntry = !selected
    }
}
