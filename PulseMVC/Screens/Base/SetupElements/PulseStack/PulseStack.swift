//
//  PulseStack.swift
//  PulseMVC
//
//  Created by Влад on 5.02.24.
//

import UIKit
class PulseStack{
    

    static func createCustomHorizStackView(pulse:String) -> UIStackView {
        let stackH = UIStackView()
        stackH.axis = .horizontal
        stackH.spacing = 6
        stackH.alignment = .center
        
        let stackV = UIStackView()
        stackV.axis = .vertical
        stackV.spacing = 2
        stackV.alignment = .center
        
        let dummyView = UIView()
        dummyView.setContentHuggingPriority(.required, for: .horizontal)
        dummyView.setContentCompressionResistancePriority(.required, for: .vertical)
        

        let pulseLabel = UILabel()
        pulseLabel.text = pulse
        pulseLabel.font = UIFont.systemFont(ofSize: 60, weight: .medium)
        
        let heartImageView = UIImageView(image: UIImage(named: "heartImage"))
        // Установка предпочтительного положения
        heartImageView.contentMode = .scaleAspectFit
        heartImageView.setContentHuggingPriority(.required, for: .horizontal)

        let bpmLabel = UILabel()
        bpmLabel.text = "bpm"
        bpmLabel.font = UIFont.systemFont(ofSize: 19, weight: .medium)

        // Добавление представлений в массив arrangedSubviews стека
        stackV.addArrangedSubview(heartImageView)
        stackV.addArrangedSubview(bpmLabel)
        
        stackH.addArrangedSubview(pulseLabel)
        stackH.addArrangedSubview(dummyView)
        stackH.addArrangedSubview(stackV)
        
        return stackH
    }
    
}

