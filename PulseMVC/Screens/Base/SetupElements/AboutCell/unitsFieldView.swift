//
//  unitsFieldView.swift
//  PulseMVC
//
//  Created by Влад on 7.02.24.
//

import UIKit
class UnitsFieldView: UIView{
    
    var label : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupGestureRecognizer()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = AppColor.buttonColor.color.cgColor
        
        
        label = UILabel()
        label.textAlignment = .center
        label.textColor = AppColor.buttonColor.color
        label.font = .systemFont(ofSize: 14, weight: .regular)
        
        self.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
        }
    }
    func selectView() {
        print("select")
        self.layer.backgroundColor = AppColor.buttonColor.color.cgColor
        label.textColor = UIColor.white
    }
    
    func deSelectView() {
        print("de-select")
        self.layer.backgroundColor = UIColor.white.cgColor
        label.textColor = AppColor.buttonColor.color
    }
}

extension UnitsFieldView{
     func setupGestureRecognizer() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            addGestureRecognizer(tapGesture)
            isUserInteractionEnabled = true
        }
        
        @objc private func handleTap(_ sender: UITapGestureRecognizer) {
            if sender.view == self {
                if label.textColor == .white {
                    deSelectView()
                } else {
                    selectView()
                }
            }
        }
}
