import UIKit

class GlobalButton: UIButton {
    
    private let buttonTitle = "Start"
    private let cornerRadius: CGFloat = 30
    private let buttonSize = CGSize(width: 300, height: 68)
    private let buttonFont = UIFont.systemFont(ofSize: 18, weight: .medium)
    private let buttonBackgroundColor = AppColor.buttonColor.color
    private let buttonTitleColor: UIColor = .white
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        backgroundColor = buttonBackgroundColor
        layer.cornerRadius = cornerRadius
        setTitle(buttonTitle, for: .normal)
        setTitleColor(buttonTitleColor, for: .normal)
        titleLabel?.font = buttonFont
        setButtonSize()
    }
    
    private func setButtonSize() {
        snp.makeConstraints { make in
            make.width.equalTo(buttonSize.width)
            make.height.equalTo(buttonSize.height)
        }
    }
}
