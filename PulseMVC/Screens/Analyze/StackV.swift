//
//  stackV.swift
//  PulseMVC
//
//  Created by vlad zarya on 16.03.24.
//

import UIKit

class StackV: UIStackView {
    
    let activityView = ActivityView()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        axis = .vertical
        distribution = .fill
        alignment = .center
        spacing = 8
        
//        activityView.backgroundColor = .red // Для отладки
//        label.backgroundColor = .green // Для отладки
        
        //activityView.setImage(named: "coffeEmoji")
        activityView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
        }
        
        //label.text = "Resting"
        label.alpha = 0.45
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        //Делегирование ответственности
        activityView.label = label // Передаем ссылку на UILabel в ActivityView
    
        
        addArrangedSubview(activityView)
        addArrangedSubview(label)
    }
}
