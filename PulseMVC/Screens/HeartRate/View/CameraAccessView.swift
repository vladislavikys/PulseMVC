//  CameraAccessView.swift
//  PulseMVC
//
//  Created by vlad zarya on 19.03.24.
//


import UIKit
import AVFoundation

class CameraAccessView: UIView {

    var okButtonAction: (() -> Void)?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.text = "Camera Access"
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Pulse would to access your camera to measure heart rate collecting the light changes of your finger surface"
        return label
    }()
    
    private let okButton: GlobalButton = {
        let button = GlobalButton()
        button.setTitle("OK", for: .normal)
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
            make.top.equalToSuperview().offset(16)
        }
        
        addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.width.equalToSuperview().inset(20)
        }
        
        addSubview(okButton)
        okButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-80)
        }
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
    }
    
    @objc private func okButtonTapped() {
        self.isHidden = true
        okButtonAction?()
        AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    // Разрешение получено
                    print("разрешение на доступ камере ПОЛУЧЕНО ")
                    
                } else {
                    // Разрешение не получено, можно добавить обработку
                    print("разрешение на доступ камере НЕ получено ")
                }
            }
    }
}

