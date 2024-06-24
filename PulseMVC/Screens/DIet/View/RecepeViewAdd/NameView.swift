//
//  NameView.swift
//  PulseMVC
//
//  Created by vlad zarya on 17.06.24.
//

import UIKit

class NameView: UIView {
    
    
    let name : String = "Name"
    let opinion : String = "Opinion"
    
    let kcal : Int = 1000
    let min : Int = 30
    let serv : Int = 2
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createBackView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createBackView()
    }
    

    private func createBackView() {
        self.frame = CGRect(x: 0, y: 0, width: 300, height: 125)
        self.backgroundColor = .white
        self.layer.cornerRadius = 50
        self.layer.masksToBounds = true
    }
}

