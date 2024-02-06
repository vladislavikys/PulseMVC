//
//  AboutMeViewController.swift
//  PulseMVC
//
//  Created by Влад on 5.02.24.
//

import UIKit
class AboutMeViewController: BaseViewController{
    
    private var continueButton = GlobalButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    private func setupUI() {
        titleLabel.text = "About me"
        
        continueButton.setTitle("Continue", for: .normal)
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        
        view.addSubview(continueButton)
        continueButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-100)
        }
    }
    
    @objc func continueTapped() {
           dismiss(animated: true) {
               UIView.animate(withDuration: 0.5) {
                   self.view.alpha = 0
               }
           }
       }
}


    
   
