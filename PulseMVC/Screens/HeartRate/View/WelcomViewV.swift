//
//  WelcomViewV.swift
//  PulseMVC
//
//  Created by Влад on 13.02.24.
//

import UIKit
class WelcomeView: UIView {
    
    var acceptButtonAction: (() -> Void)?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.text = "Welcome to Pulse"
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "By clicking \"Accept and Continue\", you confirm that you have read and accept our Privacy Policy Terms of Service."
        return label
    }()
    
    private let acceptButton: GlobalButton = {
        let button = GlobalButton()
        button.setTitle("Accept and Continue", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 24
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        
        addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.width.equalToSuperview().inset(20)
        }
        
        addSubview(acceptButton)
        acceptButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-80)
        }
        acceptButton.addTarget(self, action: #selector(acceptButtonTapped), for: .touchUpInside)
    }

    @objc private func acceptButtonTapped() {
        UserDefaults.standard.set(true, forKey: "userEnteringWelcom")
        self.isHidden = true
        acceptButtonAction?()
    }
}
