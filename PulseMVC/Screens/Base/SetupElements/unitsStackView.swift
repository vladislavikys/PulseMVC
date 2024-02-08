//
//  unitsStackView.swift
//  PulseMVC
//
//  Created by Влад on 7.02.24.
//

import UIKit
class UnitsStackView: UIStackView {
    
    let unitsCmKs = UnitsFieldView()
    let unitsInLbs = UnitsFieldView()
    
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
        self.spacing = 10
        
        let unitsCmKs = UnitsFieldView()
        let unitsInLbs = UnitsFieldView()
        
        unitsCmKs.label.text = "Cm, Kg"
        unitsInLbs.label.text = "In, Lbs"
        
        unitsCmKs.setupGestureRecognizer()
        unitsInLbs.setupGestureRecognizer()
        
        addArrangedSubview(unitsCmKs)
        addArrangedSubview(unitsInLbs)
        
        
        unitsCmKs.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(90)
        }
        
    }
}
