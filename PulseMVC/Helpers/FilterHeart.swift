//
//  FilterHeart.swift
//  PulseMVC
//
//  Created by vlad zarya on 29.03.24.
//

import Foundation

private let numberOfZeros: Int = 10
private let numberOfPoles: Int = 10
private let gain: Double = 1.894427025e+01

/*
 For more information head over to http://www-users.cs.york.ac.uk/~fisher/mkfilter/
 */

class Filter: NSObject {
    var xv = [Double](repeating: 0.0, count: numberOfZeros + 1)
    var yv = [Double](repeating: 0.0, count: numberOfPoles + 1)

    func processValue(value: Double) -> Double {
        xv[0] = xv[1]
        xv[1] = xv[2]
        xv[2] = xv[3]
        xv[3] = xv[4]
        xv[4] = xv[5]
        xv[5] = xv[6]
        xv[6] = xv[7]
        xv[7] = xv[8]
        xv[8] = xv[9]
        xv[9] = xv[10]
        xv[10] = value/gain
        
        yv[0] = yv[1]
        yv[1] = yv[2]
        yv[2] = yv[3]
        yv[3] = yv[4]
        yv[4] = yv[5]
        yv[5] = yv[6]
        yv[6] = yv[7]
        yv[7] = yv[8]
        yv[8] = yv[9]
        yv[9] = yv[10]

        yv[10] = (xv[10] - xv[0]) + 5 * (xv[2] - xv[8]) + 10 * (xv[6] - xv[4]) + (-0.0000000000 * yv[0]) + (0.0357796363 * yv[1]) + (-0.1476158522 * yv[2]) + (0.3992561394 * yv[3]) + (-1.1743136181 * yv[4]) + (2.4692165842 * yv[5]) + (-3.3820859632 * yv[6]) + (3.9628972812 * yv[7]) + (-4.3832594900 * yv[8]) + (3.2101976096 * yv[9])

        return yv[10]
    }
}
//сделал чат при комментировании
//import Foundation
//
//// Количество нулей и полюсов в фильтре
//private let numberOfZeros: Int = 10
//private let numberOfPoles: Int = 10
//private let gain: Double = 1.894427025e+01 // Коэффициент усиления фильтра
//
///*
// Фильтр - это класс, реализующий фильтрацию входных значений. Этот фильтр является IIR (Infinite Impulse Response) фильтром.
// IIR фильтры используют предыдущие выходные значения в своем вычислении, что позволяет им иметь бесконечную импульсную характеристику.
// Больше информации можно найти на http://www-users.cs.york.ac.uk/~fisher/mkfilter/
// */
//
//class Filter: NSObject {
//    // Массивы для хранения предыдущих входных и выходных значений фильтра
//    var xv = [Double](repeating: 0.0, count: numberOfZeros + 1)
//    var yv = [Double](repeating: 0.0, count: numberOfPoles + 1)
//
//    // Метод для обработки входного значения и возврата отфильтрованного результата
//    func processValue(value: Double) -> Double {
//        // Обновление массива xv для нового входного значения
//        for i in 0..<numberOfZeros {
//            xv[i] = xv[i + 1]
//        }
//        xv[numberOfZeros] = value / gain
//
//        // Обновление массива yv для нового выходного значения
//        for i in 0..<numberOfPoles {
//            yv[i] = yv[i + 1]
//        }
//
//        // Расчет нового выходного значения по коэффициентам фильтра
//        yv[numberOfPoles] = (xv[numberOfZeros] - xv[0])
//                         + 5 * (xv[2] - xv[8])
//                         + 10 * (xv[6] - xv[4])
//                         + (-0.0000000000 * yv[0])
//                         + (0.0357796363 * yv[1])
//                         + (-0.1476158522 * yv[2])
//                         + (0.3992561394 * yv[3])
//                         + (-1.1743136181 * yv[4])
//                         + (2.4692165842 * yv[5])
//                         + (-3.3820859632 * yv[6])
//                         + (3.9628972812 * yv[7])
//                         + (-4.3832594900 * yv[8])
//                         + (3.2101976096 * yv[9])
//
//        // Возврат отфильтрованного значения
//        return yv[numberOfPoles]
//    }
//}
//

