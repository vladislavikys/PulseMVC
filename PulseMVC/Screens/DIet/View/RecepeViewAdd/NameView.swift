//
//  NameView.swift
//  PulseMVC
//
//  Created by vlad zarya on 17.06.24.
//

import UIKit

class NameView: UIView {
    
    
    // Входные переменные
    var name: String = "Name" {
        //Автоматическое обновление интерфейса
        didSet { nameLabel.text = name }
    }
    
    var opinion: String = "Opinion" {
        didSet { opinionLabel.text = opinion }
    }
    
    var kcal: Int = 1000 {
        didSet { kcalLabel.text = "🔥 \(kcal) kcal" }
    }
    
    var min: Int = 30 {
        didSet { minLabel.text = " ⏰ \(min) min" }
    }
    
    var serv: Int = 2 {
        didSet { servLabel.text = "🍽️ 4\(serv) serving" }
    }
        
    // UI элементы
    private let nameLabel = UILabel()
    private let opinionLabel = UILabel()
    private let kcalLabel = UILabel()
    private let minLabel = UILabel()
    private let servLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 40
        self.layer.masksToBounds = true
        
        // Настраиваем UI элементы
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.numberOfLines = 1
        nameLabel.textAlignment = .center
        nameLabel.textColor = .black
        
        opinionLabel.font = UIFont.systemFont(ofSize: 14)
        opinionLabel.numberOfLines = 2
        opinionLabel.textAlignment = .center
        opinionLabel.textColor = .gray
        
        kcalLabel.font = UIFont.systemFont(ofSize: 10)
        kcalLabel.textColor = .black
        
        minLabel.font = UIFont.systemFont(ofSize: 10)
        minLabel.textColor = .black
        
        servLabel.font = UIFont.systemFont(ofSize: 10)
        servLabel.textColor = .black
        
        // Добавляем элементы в основной вид
        addSubview(nameLabel)
        addSubview(opinionLabel)
        addSubview(kcalLabel)
        addSubview(minLabel)
        addSubview(servLabel)
        
        // Устанавливаем ограничения с помощью SnapKit
        nameLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(10)
        }
        
        opinionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        let metrics = ["spacing": 10]
        
        let stackView = UIStackView(arrangedSubviews: [kcalLabel, minLabel, servLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(opinionLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }
    }
}

