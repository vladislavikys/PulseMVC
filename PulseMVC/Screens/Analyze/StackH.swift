//
//  stackH.swift
//  PulseMVC
//
//  Created by vlad zarya on 16.03.24.
//

import UIKit

class StackH: UIStackView, ActivityViewDelegate {
    
    // Создание трех экземпляров ActivityView
    let coffeeView = StackV()
    let sleepEmoji = StackV()
    let activityEmoji = StackV()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        axis = .horizontal
        distribution = .fillEqually
        alignment = .center
        spacing = 16 // Задайте нужный интервал
        
        // Настройка первого ActivityView
        coffeeView.activityView.setImage(named: "coffeeEmoji")
        coffeeView.label.text = "Resting"
        
        // Настройка второго ActivityView
        sleepEmoji.activityView.setImage(named: "sleepEmoji")
        sleepEmoji.label.text = "Sleep"
        
        // Настройка третьего ActivityView
        activityEmoji.activityView.setImage(named: "activityEmoji")
        activityEmoji.label.text = "Active"
        
        coffeeView.activityView.delegate = self
        sleepEmoji.activityView.delegate = self
        activityEmoji.activityView.delegate = self
        
        addArrangedSubview(coffeeView)
        addArrangedSubview(sleepEmoji)
        addArrangedSubview(activityEmoji)
    }
    
    func activityViewDidActivate(_ activityView: ActivityView) {
            let views = [coffeeView.activityView, sleepEmoji.activityView, activityEmoji.activityView]
            
            // Деактивация всех, кроме активированного
            views.forEach { view in
                if view !== activityView { // Используем идентичность, а не равенство
                    //Оператор идентичности (!==) проверяет, что два объекта не являются одним и тем же объектом в памяти.
                    view.isActive = false
                }
            }
        }
}

 
