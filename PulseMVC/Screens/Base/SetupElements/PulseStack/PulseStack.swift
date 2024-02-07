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
        spacing = 10
        
        // Настройка вертикального стека
        stackV.axis = .vertical
        stackV.spacing = 2
        stackV.alignment = .center
        
        // Настройка дамми-представления
        dummyView.setContentHuggingPriority(.required, for: .horizontal)
        dummyView.setContentCompressionResistancePriority(.required, for: .vertical)
        
        // Настройка метки пульса
        pulseLabel.font = UIFont.systemFont(ofSize: 60, weight: .medium)
        
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







////        let stackH = UIStackView()
////        stackH.axis = .horizontal
////        stackH.spacing = 6
////        stackH.alignment = .center
//
//
//        stackV.axis = .vertical
//        stackV.spacing = 2
//        stackV.alignment = .center
//
//
//        dummyView.setContentHuggingPriority(.required, for: .horizontal)
//        dummyView.setContentCompressionResistancePriority(.required, for: .vertical)
//
//
//
//        pulseLabel.text = pulse
//        pulseLabel.font = UIFont.systemFont(ofSize: 60, weight: .medium)
//
//        let heartImageView = UIImageView(image: UIImage(named: "heartImage"))
//        // Установка предпочтительного положения
//        heartImageView.contentMode = .scaleAspectFit
//        heartImageView.setContentHuggingPriority(.required, for: .horizontal)
//
//        let bpmLabel = UILabel()
//        bpmLabel.text = "bpm"
//        bpmLabel.font = UIFont.systemFont(ofSize: 19, weight: .medium)
//
//        // Добавление представлений в массив arrangedSubviews стека
//        stackV.addArrangedSubview(heartImageView)
//        stackV.addArrangedSubview(bpmLabel)
//
//        stackH.addArrangedSubview(pulseLabel)
//        stackH.addArrangedSubview(dummyView)
//        stackH.addArrangedSubview(stackV)
//
//        return stackH
//    }



