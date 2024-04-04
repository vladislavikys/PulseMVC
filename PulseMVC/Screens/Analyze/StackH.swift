//
//  stackH.swift
//  PulseMVC
//
//  Created by vlad zarya on 16.03.24.
//

import UIKit

protocol StackHDelegate: AnyObject {
    func didSelectActivityView(named imageName: String)
}

class StackH: UIStackView, ActivityViewDelegate {
    
    weak var delegate: StackHDelegate?
    
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
        
        
        coffeeView.activityView.nameEmoji = "coffeeEmoji"
        coffeeView.activityView.setImage(named: coffeeView.activityView.nameEmoji)
        coffeeView.label.text = "Resting"
        
        sleepEmoji.activityView.nameEmoji = "sleepEmoji"
        sleepEmoji.activityView.setImage(named: sleepEmoji.activityView.nameEmoji)
        sleepEmoji.label.text = "Sleep"
        
        activityEmoji.activityView.nameEmoji = "activityEmoji"
        activityEmoji.activityView.setImage(named: activityEmoji.activityView.nameEmoji)
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
            if view !== activityView {
                // проверка что они не являются одним  объектом в памяти тип
                view.isActive = false
            }
        }
        
        if (views.first != nil) == activityView.isActive {
            print("activityimage = \(activityView.nameEmoji)")
            delegate?.didSelectActivityView(named: activityView.nameEmoji)
        }
        
    }
}


