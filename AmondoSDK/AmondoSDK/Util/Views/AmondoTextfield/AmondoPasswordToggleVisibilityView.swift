import Foundation
import UIKit

protocol PasswordToggleVisibilityDelegate: class {
    func viewWasToggled(passwordToggleVisibilityView: AmondoPasswordToggleVisibilityView, isSelected selected: Bool)
}

final class AmondoPasswordToggleVisibilityView: UIView {
    private let eyeOpenedImage: UIImage
    private let eyeClosedImage: UIImage
    private let buttonEye: UIButton

    weak var delegate: PasswordToggleVisibilityDelegate?

    enum EyeState {
        case Open
        case Closed
    }

    var eyeState: EyeState {
        set {
            buttonEye.isSelected = newValue == .Open
        }
        get {
            return buttonEye.isSelected ? .Open : .Closed
        }
    }

    override var tintColor: UIColor! {
        didSet {
            buttonEye.tintColor = tintColor
        }
    }

    override init(frame: CGRect) {
        self.eyeOpenedImage = UIImage(named: "eye-opened")!
        self.eyeClosedImage = UIImage(named: "eye-closed")!

        self.buttonEye = UIButton(type: .custom)
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Don't use init with coder.")
    }

    private func setupViews() {
        let buttonWidth: CGFloat = 24.0
        let buttonFrame = CGRect(x: 0.0, y: 0, width: buttonWidth, height: frame.height)
        buttonEye.frame = buttonFrame
        buttonEye.adjustsImageWhenHighlighted = false
        buttonEye.setImage(self.eyeClosedImage.withRenderingMode(.alwaysTemplate), for: .normal)
        buttonEye.setImage(self.eyeOpenedImage.withRenderingMode(.alwaysTemplate), for: .selected)
        buttonEye.addTarget(self, action: #selector(buttonEyePressed), for: .touchUpInside)

        buttonEye.tintColor = self.tintColor
        self.addSubview(buttonEye)
    }

    @objc func buttonEyePressed(sender: AnyObject) {
        buttonEye.isSelected = !buttonEye.isSelected
        delegate?.viewWasToggled(passwordToggleVisibilityView: self, isSelected: buttonEye.isSelected)
    }
}
