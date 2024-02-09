//
//  unitsStackView.swift
//  PulseMVC
//
//  Created by Влад on 7.02.24.
//

import UIKit
class UnitsStackView: UIStackView {
        
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
        
        unitsCmKs.selectView()
        
        unitsCmKs.setupGestureRecognizer()
        unitsInLbs.setupGestureRecognizer()
        
        unitsCmKs.selectionHandler = { [weak self] in
            unitsInLbs.deSelectView()
        }
        unitsInLbs.selectionHandler = { [weak self] in
            unitsCmKs.deSelectView()
        }
        
        addArrangedSubview(unitsCmKs)
        addArrangedSubview(unitsInLbs)
        
        unitsCmKs.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(90)
        }
    }
}
