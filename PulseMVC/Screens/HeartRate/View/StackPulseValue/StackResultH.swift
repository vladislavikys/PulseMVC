//
//  StackH.swift
//  PulseMVC
//
//  Created by vlad zarya on 26.03.24.
//

import UIKit

class StackResultH: UIStackView {
    
    private var heartImage = UIImageView(image: UIImage(named: "heartImage"))
    var pulseLabel = UILabel()
    private  let bpmLabel = UILabel()
    
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
        self.spacing = 20
        
        heartImage.contentMode = .scaleAspectFit
        
        pulseLabel.text = "80"
        pulseLabel.font = .systemFont(ofSize: 50, weight: .medium)
        
        bpmLabel.text = "bpm"
        
        addSubview(heartImage)
        addSubview(pulseLabel)
        addSubview(bpmLabel)
        
        heartImage.snp.makeConstraints { make in
            make.height.width.equalTo(18)
            make.centerY.equalToSuperview()
        }
        
        pulseLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(heartImage.snp.trailing).offset(10)
        }
        
        bpmLabel.snp.makeConstraints { make in
            make.centerY.equalTo(6)
            make.leading.equalTo(pulseLabel.snp.trailing).offset(10)
        }
    }
}
