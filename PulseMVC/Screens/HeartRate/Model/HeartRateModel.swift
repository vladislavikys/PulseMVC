//
//  HeartRateModel.swift
//  PulseMVC
//
//  Created by vlad zarya on 4.04.24.
//

import UIKit

// Протокол, описывающий взаимодействие с контроллером сердечного ритма
protocol BindWithHearControllerProtocol {
    // Расчёт и сохранение данных о пульсе в базу данных
    func calculatingAndSaveToDBBpmData(pulse: [Int])
}

class HeartRateModel: BindWithHearControllerProtocol {
    
    func calculatingAndSaveToDBBpmData(pulse: [Int]) {
        guard !pulse.isEmpty else {
            print("bpmForCalculating PUSTOJ")
            return } // Проверяем, что массив не пуст
        
        //  сумму всех значений
        let sumPulse = pulse.reduce(0, +)
        //  среднее значение
        let averagePulse = sumPulse / pulse.count
        CoreDataeManager.shared.updateProfile(bpmAverage: averagePulse)
    }
}
