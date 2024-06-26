//
//  AboutModel.swift
//  PulseMVC
//
//  Created by Влад on 6.02.24.
//

import UIKit

class AboutModel : Codable {
    var gender: String? // Пол
    var height: Int?    // Рост
    var weight: Int?    // Вес
    var age: Int?       // Возраст
    var units: String?  // Выбранные единицы измерения (например, "Cm, Kg" или "In, Lbs")
    
    func update(gender: String?, height: Int?, weight: Int?, age: Int?, units: String?) {
        self.gender = gender
        self.height = height
        self.weight = weight
        self.age = age
        self.units = units
        
        let model:AboutModel = AboutModel()
        
        model.gender = "Male"
    }
}

//для проверки на экране ABOUT что все данные введены
extension AboutModel {
    var isComplete: Bool {
        return height != nil && weight != nil && age != nil
    }
}
