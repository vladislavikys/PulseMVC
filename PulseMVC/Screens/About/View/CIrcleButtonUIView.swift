import UIKit

enum CircleButtonViewState {
    case selected
    case deselected
}

class CircleButtonUIView: UIView {
    
    var circleFill: UIView!
    var state: CircleButtonViewState = .deselected
    var genderLabel: UILabel!
    
    var selectionHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = AppColor.buttonColor.color.cgColor
        
        circleFill = UIView()
        circleFill.layer.cornerRadius = 7
        
        genderLabel = UILabel()
        genderLabel.textColor = .black
        genderLabel.isUserInteractionEnabled = true
        
        addSubview(circleFill)
        circleFill.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(14)
        }
        addSubview(genderLabel)
        genderLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(circleFill.snp.trailing).offset(8)
        }
    }
    
    func selectView() {
        circleFill.backgroundColor = AppColor.buttonColor.color
        genderLabel.textColor = AppColor.buttonColor.color
        state = .selected
    }
    func deSelectView() {
        circleFill.backgroundColor = .clear
        genderLabel.textColor = .black
        state = .deselected
    }
}

extension CircleButtonUIView{
    func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
        
        
        //пробовал по нажатию тексат выбор втю но ХУЙ ТАМ
        
        let labelTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLabelTap(_:)))
        genderLabel.addGestureRecognizer(labelTapGesture)
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        switch state {
        case .selected:
            deSelectView()
        case .deselected:
            selectView()
            selectionHandler?()
        }
    }
    @objc private func  handleLabelTap(_ sender: UITapGestureRecognizer) {
        switch state {
        case .selected:
            deSelectView()
        case .deselected:
            selectView()
            selectionHandler?()
        }
    }
}
