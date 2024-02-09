//
//  CircleButtonHStack.swift
//  PulseMVC
//
//  Created by Влад on 8.02.24.
//

import UIKit
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
        
        oneButtton.setupGestureRecognizer()
        twoButton.setupGestureRecognizer()
        
        oneButtton.selectionHandler = { [weak self] in
            self?.twoButton.deSelectView()
        }
        
        twoButton.selectionHandler = { [weak self] in
            self?.oneButtton.deSelectView()
        }
        
        addArrangedSubview(oneButtton)
        addArrangedSubview(twoButton)
        
        
        oneButtton.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
    }
}
    
