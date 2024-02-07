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
        label.text = "In, Lbs"
        
        self.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
        }
        
        
    }
    
    func selectView() {
        
    }
    
    func deSelectView() {
        
    }
    
    
}
