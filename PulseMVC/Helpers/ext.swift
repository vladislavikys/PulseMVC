//
//  ext.swift
//  PulseMVC
//
//  Created by vlad zarya on 4.04.24.
//

import UIKit
extension PulseViewController {
    func printDB(){
        if let coreData = CoreDataeManager.shared.fetchProfile(){
            // Распечатываем данные пользователя
            print("-----------------")
            print("Выбранные единицы измерения: \(coreData.units ?? "Не указаны")")
            print("Пол: \(coreData.gender ?? "Не указан")")
            print("Рост: \(coreData.height)")
            print("Вес: \(coreData.weight)")
            print("Возраст: \(coreData.age)")
            print("BPM: \(String(describing: coreData.bpm))")
            print("-----------------")
        }
    }
}
