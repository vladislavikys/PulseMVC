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
    func createDefResepies(){
       
        CoreDataeManager.shared.createRecipe(name: "Овсяная каша с протеином и фруктами",
                    photo: "eat",
                    calories: 350,
                    cookingTime: 10,
                    description: "Питательный и вкусный завтрак для спортсменов",
                    ingredients: "Овсяные хлопья, протеиновый порошок, банан, ягоды, молоко",
                    carbohydrates: 45,
                    fat: 5,
                    protein: 25,
                    servings: 1,
                    category: "Завтрак")

       
        CoreDataeManager.shared.createRecipe(name: "Куриная грудка с гарниром из риса и овощами",
                    photo: "chiken",
                    calories: 450,
                    cookingTime: 30,
                    description: "Сбалансированный обед с высоким содержанием белка и клетчатки",
                    ingredients: "Куриная грудка, коричневый рис, брокколи, морковь, лук",
                    carbohydrates: 40,
                    fat: 10,
                    protein: 40,
                    servings: 2,
                    category: "Обед")


        CoreDataeManager.shared.createRecipe(name: "Протеиновый смузи с бананом и арахисовым маслом",
                    photo: "smuzi",
                    calories: 300,
                    cookingTime: 5,
                    description: "Питательный напиток для восстановления после тренировки",
                    ingredients: "Протеиновый порошок, банан, арахисовое масло, молоко",
                    carbohydrates: 30,
                    fat: 15,
                    protein: 25,
                    servings: 1,
                    category: "Завтрак")

        CoreDataeManager.shared.createRecipe(name: "Запеченная форель с гарниром из картофеля и шпината",
                    photo: "forel",
                    calories: 500,
                    cookingTime: 40,
                    description: "Полезный ужин с богатым источником белка и здоровых жиров",
                    ingredients: "Форель, сладкий картофель, шпинат, лимон, оливковое масло",
                    carbohydrates: 35,
                    fat: 20,
                    protein: 35,
                    servings: 2,
                    category: "Ужин")

        CoreDataeManager.shared.createRecipe(name: "Греческий йогурт с гранолой и фруктами",
                    photo: "jogurt",
                    calories: 250,
                    cookingTime: 5,
                    description: "Легкий перекус с сочетанием белка, клетчатки и медленных углеводов",
                    ingredients: "Греческий йогурт, гранола, яблоко, голубика",
                    carbohydrates: 30,
                    fat: 8,
                    protein: 18,
                    servings: 1,
                    category: "Перекус")
    }
}
