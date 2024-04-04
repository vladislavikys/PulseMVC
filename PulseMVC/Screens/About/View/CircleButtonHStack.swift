import UIKit
import CoreData

class CircleButtonHStack: UIStackView {
    
    let oneButtton = CircleButtonUIView()
    let twoButton = CircleButtonUIView()
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.alignment = .fill
        self.spacing = 60
        
        oneButtton.genderLabel.text = "Male"
        twoButton.genderLabel.text = "Female"
        
        oneButtton.selectView()
        saveCoreData(gender: "Male")
        
        oneButtton.setupGestureRecognizer()
        twoButton.setupGestureRecognizer()
        
        
        
        oneButtton.selectionHandler = { [weak self] in
            self?.twoButton.deSelectView()
            self?.saveCoreData(gender: "Male")
        }
        
        twoButton.selectionHandler = { [weak self] in
            self?.oneButtton.deSelectView()
            self?.saveCoreData(gender: "Female")
        }
        
        addArrangedSubview(oneButtton)
        addArrangedSubview(twoButton)
        
        oneButtton.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
    }
}

extension CircleButtonHStack {
    private func saveCoreData(gender: String){
        CoreDataeManager.shared.updateProfile(gender: gender)
    }
    
}
