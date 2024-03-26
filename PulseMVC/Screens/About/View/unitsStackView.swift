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
        addTaps()
        bindings()
        unitsCmKs.selectView()
        self.saveUnitsCoreData(units: self.unitsCmKs.label.text!)
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        addTaps()
        bindings()
    }
    
    private func setupView() {
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.alignment = .fill
        self.spacing = 10
        
        unitsCmKs.label.text = "Cm, Kg"
        unitsInLbs.label.text = "In, lbs"
        self.saveUnitsCoreData(units: self.unitsCmKs.label.text ?? "")
        
        addArrangedSubview(unitsCmKs)
        addArrangedSubview(unitsInLbs)
        
        unitsCmKs.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(90)
        }
    }
    
    private func addTaps() {
        unitsCmKs.setupGestureRecognizer()
        unitsInLbs.setupGestureRecognizer()
    }
    
    private func bindings() {
        unitsCmKs.selectionHandler = {
            self.saveUnitsCoreData(units: self.unitsCmKs.label.text ?? "")
            self.unitsInLbs.deSelectView()
        }
        unitsInLbs.selectionHandler = {
            self.saveUnitsCoreData(units: self.unitsInLbs.label.text ?? "")
            self.unitsCmKs.deSelectView()
        }
    }
    
    private func saveUnitsCoreData(units: String){
//        CoreDataeManager.shared.deleteProfile(byAttribute: "units")
//        CoreDataeManager.shared.createUnits(units: units)
        CoreDataeManager.shared.updateProfile(units: units)
    }
}
