//
//  PulseDetectorHeart.swift
//  PulseMVC
//
//  Created by vlad zarya on 29.03.24.
//
import Foundation
import QuartzCore

// Константы для управления логикой обнаружения пульса
private let maxPeriodsToStore = 20 // Максимальное количество сохраняемых периодов
private let averageSize = 20 // Размер среднего значения для обнаружения пульса
private let invalidPulsePeriod = -1 // Значение, указывающее на отсутствие обнаруженного пульса
private let maxPeriod = 1.5 // Максимально допустимый период обнаружения пульса
private let minPeriod = 0.1 // Минимально допустимый период обнаружения пульса
private let invalidEntry: Double = -100 // Недопустимое значение в массивах

class PulseDetector: NSObject {
    // Массивы для хранения значений вершин и впадин входного сигнала
    private var upVals = [Double](repeating: 0.0, count: averageSize)
    private var downVals = [Double](repeating: 0.0, count: averageSize)
    private var upValIndex = 0
    private var downValIndex = 0
    private var lastVal: Float = 0.0
    
    // Массивы для хранения периодов обнаруженного пульса
    private var periods = [Double](repeating: 0.0, count: maxPeriodsToStore)
    private var periodTimes = [Double](repeating: 0.0, count: maxPeriodsToStore)
    private var periodIndex = 0
    private var started = false
    private var freq: Float = 0.0
    private var average: Float = 0.0
    private var wasDown = false
    
    private var periodStart: Double = 0.0
    
    // Инициализация, устанавливающая все значения в недопустимые
    override init() {
        super.init()
        reset()
    }

    // Метод для добавления нового значения и определения его типа (вершина, впадина или ничего)
    func addNewValue(newVal: Double, atTime time: Double) -> Float {
        if newVal > 0 {
            // Запись положительных значений в массив вершин
            upVals[upValIndex] = newVal
            upValIndex += 1
            if upValIndex >= averageSize {
                upValIndex = 0
            }
        }
        
        if newVal < 0 {
            // Запись отрицательных значений в массив впадин
            downVals[downValIndex] = -newVal
            downValIndex += 1
            if downValIndex >= averageSize {
                downValIndex = 0
            }
        }
        
        // Вычисление средних значений для вершин и впадин
        var count: Double = 0
        var total: Double = 0
        for i in 0..<averageSize {
            if upVals[i] != invalidEntry {
                count += 1
                total += upVals[i]
            }
        }
        
        let averageUp: Double = total/count
        
        count = 0
        total = 0
        for i in 0..<averageSize {
            if downVals[i] != invalidEntry {
                count += 1
                total += downVals[i]
            }
        }
        let averageDown: Double = total/count
        
        if newVal < -0.5 * averageDown {
            wasDown = true
        }
        
        // Определение типа нового значения и его обработка
        if newVal >= 0.5 * averageUp && wasDown {
            wasDown = false
            if time - periodStart < maxPeriod && time - periodStart > minPeriod {
                // Запись периода обнаруженного пульса
                periods[periodIndex] = time - periodStart
                periodTimes[periodIndex] = time
                periodIndex += 1
                if periodIndex >= maxPeriodsToStore {
                    periodIndex = 0
                }
            }
            periodStart = time
        }
        
        // Возвращение значения, указывающего на вершину, впадину или отсутствие события
        if newVal < -0.5 * averageDown {
            return -1
        } else if newVal > 0.5 * averageUp {
            return 1
        }
        return 0
    }

    // Метод для получения среднего значения периода обнаруженного пульса
    func getAverage() -> Float {
        let time = CACurrentMediaTime()
        var total: Double = 0
        var count: Double = 0
        for i in 0..<maxPeriodsToStore {
            // Используем данные только за последние 10 секунд
            if periods[i] != invalidEntry && time - periodTimes[i] < 10 {
                count += 1
                total += periods[i]
            }
        }
        // Возвращаем среднее значение, если у нас достаточно данных
        if count > 2 {
            return Float(total / count)
        }
        return Float(invalidPulsePeriod)
    }

    // Метод для сброса всех значений
    func reset() {
        for i in 0..<maxPeriodsToStore {
            periods[i] = invalidEntry
        }
        for i in 0..<averageSize {
            upVals[i] = invalidEntry
            downVals[i] = invalidEntry
        }
        freq = 0.5
        periodIndex = 0
        downValIndex = 0
        upValIndex = 0
    }
}
