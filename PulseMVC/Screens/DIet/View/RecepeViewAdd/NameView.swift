//
//  NameView.swift
//  PulseMVC
//
//  Created by vlad zarya on 17.06.24.
//

import UIKit

class NameView: UIView {
    
    
    let name : String = ""
    let opinion : String = ""
    
    let kcal : Int = 0
    let min : Int = 0
    let serv : Int = 0
    
    
    // Инициализация через код
    override init(frame: CGRect) {
        super.init(frame: frame)
        createBackView()
    }
    
    // Инициализация через Interface Builder (Storyboard или XIB)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createBackView()
    }
    
    // Метод настройки внешнего вида
    private func createBackView() {
        self.frame = CGRect(x: 0, y: 0, width: 300, height: 125)
        self.backgroundColor = .white
        self.layer.cornerRadius = 50
        self.layer.masksToBounds = true
    }
}

