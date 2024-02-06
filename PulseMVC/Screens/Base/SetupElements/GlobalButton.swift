//
//  GlobalButton.swift
//  PulseMVC
//
//  Created by Влад on 4.02.24.
//

import UIKit

class GlobalButton:UIButton{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton(){
        
        self.backgroundColor = AppColor.buttonColor.color
        self.layer.cornerRadius = 30
        self.setTitle("Start", for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 18,weight: .medium)
        
        self.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(75)
        }
    }
}
