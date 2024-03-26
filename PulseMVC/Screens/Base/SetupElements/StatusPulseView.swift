//
//  StatusPulseView.swift
//  PulseMVC
//
//  Created by vlad zarya on 26.03.24.
//

import UIKit

class StatusPulseView: UIView {
    
    private  var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        // Установка размеров и закругление
        self.layer.cornerRadius = 15
        
        label = UILabel()
        label.textAlignment = .center
        label.textColor = AppColor.status.color
        label.font = .systemFont(ofSize: 14, weight: .regular)
        
        // Добавление метки на вид
        addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
        }
    }
    
    // Публичный метод для установки текста
    func setLabelText(_ text: String) {
        label.text = text
    }
    
    func setLabelTextColor(_ color: UIColor) {
        label.textColor = color
    }
}
extension StatusPulseView {
    func setPulseStatus(_ status: PulseStatus) {
            switch status {
            case .normal:
                setLabelText("Normal pulse")
                backgroundColor = UIColor.yellow.withAlphaComponent(0.2)
                setLabelTextColor(UIColor.orange)
            case .bad:
                setLabelText("Bad pulse")
                backgroundColor = UIColor.red.withAlphaComponent(0.2)
                setLabelTextColor(UIColor.red)
            case .good:
                setLabelText("Good pulse")
                backgroundColor = AppColor.status.color.withAlphaComponent(0.2)
                setLabelTextColor(AppColor.status.color)
                
            }
        }
}
