//
//  PulseStack.swift
//  PulseMVC
//
//  Created by Влад on 5.02.24.
//

import UIKit
class PulseStack: UIStackView{
    
    let stackV = UIStackView()
    let dummyView = UIView()
    let pulseLabel = UILabel()
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        setupStack()
    }
    
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupStack()
    }
    
    func setupStack() {
        axis = .horizontal // Главный стек располагается горизонтально
        alignment = .center
        spacing = 1
        
        // Настройка вертикального стека
        stackV.axis = .vertical
        stackV.spacing = 2
        stackV.alignment = .center
        
        // Настройка дамми-представления
        dummyView.setContentHuggingPriority(.required, for: .horizontal)
        dummyView.setContentCompressionResistancePriority(.required, for: .vertical)
        
        // Настройка метки пульса
        pulseLabel.font = UIFont.systemFont(ofSize: 60, weight: .medium)
        pulseLabel.textAlignment = .center
        pulseLabel.adjustsFontSizeToFitWidth = true
        pulseLabel.minimumScaleFactor = 0.5
        pulseLabel.numberOfLines = 1
        pulseLabel.lineBreakMode = .byTruncatingTail
        pulseLabel.snp.makeConstraints { make in
            make.width.equalTo(90)
        }
        
        
        // Создание и настройка изображения сердца
        let heartImageView = UIImageView(image: UIImage(named: "heartImage"))
        heartImageView.contentMode = .scaleAspectFit
        heartImageView.setContentHuggingPriority(.required, for: .horizontal)
        
        // Настройка метки "bpm"
        let bpmLabel = UILabel()
        bpmLabel.text = "bpm"
        bpmLabel.font = UIFont.systemFont(ofSize: 19, weight: .medium)
        
        // Добавление представлений в стеки
        stackV.addArrangedSubview(heartImageView)
        stackV.addArrangedSubview(bpmLabel)
        
        addArrangedSubview(pulseLabel)
        addArrangedSubview(dummyView)
        addArrangedSubview(stackV)
    }
}
