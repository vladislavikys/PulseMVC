//
//  ext.swift
//  PulseMVC
//
//  Created by vlad zarya on 4.04.24.
//

import UIKit

extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}

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
       
        CoreDataeManager.shared.createRecipe(
            name: "Овсяная каша с протеином и фруктами",
                    photo: "eat",
                    calories: 350,
                    cookingTime: 10,
                    description: "Питательный и вкусный завтрак для спортсменов",
                    ingredients: "Овсяные хлопья, протеиновый порошок, банан, ягоды, молоко",
                    carbohydrates: 45,
                    fat: 5,
                    protein: 25,
                    servings: 1,
                    category: "Завтрак",
            instructions: """
            1. Залейте овсяные хлопья молоком и варите на среднем огне.
            2. Добавьте протеиновый порошок и хорошо перемешайте.
            3. Нарежьте банан и добавьте в кашу.
            4. Добавьте ягоды и подавайте горячим.
            """)

       
        CoreDataeManager.shared.createRecipe(
            name: "Куриная грудка с гарниром из риса и овощами",
            photo: "chiken",
            calories: 450,
            cookingTime: 30,
            description: "Сбалансированный обед с высоким содержанием белка и клетчатки",
            ingredients: "Куриная грудка, коричневый рис, брокколи, морковь, лук",
            carbohydrates: 40,
            fat: 10,
            protein: 40,
            servings: 2,
            category: "Обед",
            instructions: """
            1. Отварите рис до готовности.
            2. Нарежьте куриную грудку и обжарьте на сковороде.
            3. Добавьте нарезанные овощи (брокколи, морковь, лук) и тушите до готовности.
            4. Подавайте курицу с гарниром из риса и овощей.
            """
        )

        CoreDataeManager.shared.createRecipe(
            name: "Протеиновый смузи с бананом и арахисовым маслом",
            photo: "smuzi",
            calories: 300,
            cookingTime: 5,
            description: "Питательный напиток для восстановления после тренировки",
            ingredients: "Протеиновый порошок, банан, арахисовое масло, молоко",
            carbohydrates: 30,
            fat: 15,
            protein: 25,
            servings: 1,
            category: "Завтрак",
            instructions: """
            1. Смешайте все ингредиенты в блендере.
            2. Перемешайте до однородной массы.
            3. Перелейте в стакан и подавайте.
            """
        )

        CoreDataeManager.shared.createRecipe(
            name: "Запеченная форель с гарниром из картофеля и шпината",
            photo: "forel",
            calories: 500,
            cookingTime: 40,
            description: "Полезный ужин с богатым источником белка и здоровых жиров",
            ingredients: "Форель, сладкий картофель, шпинат, лимон, оливковое масло",
            carbohydrates: 35,
            fat: 20,
            protein: 35,
            servings: 2,
            category: "Ужин",
            instructions: """
            1. Разогрейте духовку до 180°C.
            2. Запеките форель, приправленную лимоном и оливковым маслом, в течение 25 минут.
            3. Отварите сладкий картофель до готовности.
            4. Обжарьте шпинат на сковороде с небольшим количеством оливкового масла.
            5. Подавайте форель с гарниром из картофеля и шпината.
            """
        )

        CoreDataeManager.shared.createRecipe(
            name: "Греческий йогурт с гранолой и фруктами",
            photo: "jogurt",
            calories: 250,
            cookingTime: 5,
            description: "Легкий перекус с сочетанием белка, клетчатки и медленных углеводов",
            ingredients: "Греческий йогурт, гранола, яблоко, голубика",
            carbohydrates: 30,
            fat: 8,
            protein: 18,
            servings: 1,
            category: "Завтрак",
            instructions: """
            1. Выложите йогурт в миску.
            2. Посыпьте гранолой.
            3. Добавьте нарезанное яблоко и голубику.
            4. Перемешайте и подавайте.
            """
        )
        
        //--------new gpt
        
        CoreDataeManager.shared.createRecipe(
            name: "Салат с тунцом и фасолью",
            photo: "tuna_salad",
            calories: 350,
            cookingTime: 15,
            description: "Легкий и питательный салат с высоким содержанием белка",
            ingredients: "Тунец, фасоль, помидоры, огурцы, оливковое масло, лимонный сок",
            carbohydrates: 20,
            fat: 15,
            protein: 25,
            servings: 2,
            category: "Обед",
            instructions: """
            1. Смешайте тунец и фасоль в миске.
            2. Нарежьте помидоры и огурцы, добавьте к тунцу и фасоли.
            3. Заправьте салат оливковым маслом и лимонным соком.
            4. Перемешайте и подавайте.
            """
        )

        CoreDataeManager.shared.createRecipe(
            name: "Крем-суп из брокколи и сыра",
            photo: "broccoli_soup",
            calories: 300,
            cookingTime: 30,
            description: "Кремовый суп с брокколи и плавленым сыром",
            ingredients: "Брокколи, сыр, лук, картофель, сливки",
            carbohydrates: 20,
            fat: 20,
            protein: 10,
            servings: 4,
            category: "Ужин",
            instructions: """
            1. Отварите брокколи и картофель до готовности.
            2. Обжарьте лук до золотистого цвета.
            3. Добавьте брокколи, картофель и лук в блендер и измельчите.
            4. Перелейте смесь в кастрюлю, добавьте сливки и плавленый сыр, перемешайте.
            5. Варите на среднем огне до однородной массы.
            """
        )

        CoreDataeManager.shared.createRecipe(
            name: "Куриный шашлык с овощами",
            photo: "chicken_skewers",
            calories: 400,
            cookingTime: 35,
            description: "Сочное куриное мясо на гриле с овощами",
            ingredients: "Курица, болгарский перец, лук, кабачки, оливковое масло",
            carbohydrates: 15,
            fat: 25,
            protein: 35,
            servings: 3,
            category: "Ужин",
            instructions: """
            1. Нарежьте курицу и овощи на кусочки.
            2. Наденьте курицу и овощи на шпажки.
            3. Смажьте оливковым маслом и приправьте специями.
            4. Жарьте на гриле до готовности.
            """
        )

        CoreDataeManager.shared.createRecipe(
            name: "Рататуй с баклажанами и помидорами",
            photo: "ratatouille",
            calories: 200,
            cookingTime: 40,
            description: "Традиционное французское блюдо с овощами",
            ingredients: "Баклажаны, помидоры, цуккини, лук, оливковое масло, чеснок",
            carbohydrates: 25,
            fat: 10,
            protein: 5,
            servings: 4,
            category: "Ужин",
            instructions: """
            1. Нарежьте все овощи кружочками.
            2. Выложите овощи в форму для запекания слоями.
            3. Полейте оливковым маслом и добавьте чеснок.
            4. Запекайте в духовке при 180°
            """
            )

        CoreDataeManager.shared.createRecipe(
            name: "Смузи с манго и шпинатом",
            photo: "mango_smoothie",
            calories: 180,
            cookingTime: 5,
            description: "Освежающий и полезный смузи",
            ingredients: "Манго, шпинат, банан, кокосовая вода",
            carbohydrates: 35,
            fat: 2,
            protein: 2,
            servings: 1,
            category: "Завтрак",
            instructions: """
            1. Смешайте все ингредиенты в блендере.
            2. Перемешайте до однородной массы.
            3. Перелейте в стакан и подавайте.
            """
        )

        CoreDataeManager.shared.createRecipe(
            name: "Паста с креветками и чесночным соусом",
            photo: "shrimp_pasta",
            calories: 450,
            cookingTime: 25,
            description: "Вкусная паста с креветками и ароматным чесночным соусом",
            ingredients: "Паста, креветки, чеснок, сливки, пармезан, петрушка",
            carbohydrates: 55,
            fat: 15,
            protein: 25,
            servings: 2,
            category: "Ужин",
            instructions: """
            1. Отварите пасту до готовности.
            2. Обжарьте чеснок до золотистого цвета.
            3. Добавьте креветки и готовьте до розового цвета.
            4. Добавьте сливки и пармезан, перемешайте.
            5. Смешайте пасту с соусом и подавайте с петрушкой.
            """
        )

        CoreDataeManager.shared.createRecipe(
            name: "Овсяноблин с фруктами и йогуртом",
            photo: "oat_pancake",
            calories: 250,
            cookingTime: 10,
            description: "Питательный овсяноблин с добавлением свежих фруктов и йогурта",
            ingredients: "Овсянка, яйцо, молоко, клубника, банан, греческий йогурт",
            carbohydrates: 40,
            fat: 5,
            protein: 10,
            servings: 1,
            category: "Завтрак",
            instructions: """
            1. Смешайте овсянку, яйцо и молоко до однородной массы.
            2. Вылейте смесь на сковороду и обжарьте с обеих сторон.
            3. Нарежьте клубнику и банан, добавьте на овсяноблин.
            4. Полейте греческим йогуртом и подавайте.
            """
        )

        CoreDataeManager.shared.createRecipe(
            name: "Гречневая каша с грибами и луком",
            photo: "buckwheat",
            calories: 300,
            cookingTime: 20,
            description: "Сытное и полезное блюдо из гречки с грибами и луком",
            ingredients: "Гречка, грибы, лук, масло, специи",
            carbohydrates: 55,
            fat: 10,
            protein: 10,
            servings: 2,
            category: "Обед",
            instructions: """
            1. Отварите гречку до готовности.
            2. Обжарьте грибы и лук до золотистого цвета.
            3. Смешайте гречку с грибами и луком.
            4. Подавайте горячим.
            """
        )

        CoreDataeManager.shared.createRecipe(
            name: "Морковный пирог с орехами",
            photo: "carrot_cake",
            calories: 350,
            cookingTime: 60,
            description: "Вкусный и полезный десерт с морковью и орехами",
            ingredients: "Морковь, мука, яйца, сахар, орехи, масло",
            carbohydrates: 50,
            fat: 15,
            protein: 5,
            servings: 8,
            category: "Ужин",
            instructions: """
            1. Натрите морковь на терке.
            2. Смешайте морковь с мукой, яйцами, сахаром и орехами.
            3. Выложите смесь в форму для запекания.
            4. Выпекайте при 180°C около 60 минут.
            """
        )

        CoreDataeManager.shared.createRecipe(
            name: "Салат Цезарь с курицей",
            photo: "caesar_salad",
            calories: 400,
            cookingTime: 20,
            description: "Классический салат Цезарь с куриным филе",
            ingredients: "Курица, салат ромэн, пармезан, крутоны, цезарь соус",
            carbohydrates: 20,
            fat: 25,
            protein: 30,
            servings: 2,
            category: "Обед",
            instructions: """
            1. Обжарьте курицу до готовности и нарежьте ломтиками.
            2. Смешайте салат ромэн с курицей.
            3. Добавьте пармезан и крутоны.
            4. Полейте цезарь соусом и подавайте.
            """
        )

        CoreDataeManager.shared.createRecipe(
            name: "Салат с киноа и авокадо",
            photo: "salad",
            calories: 400,
            cookingTime: 15,
            description: "Легкий и полезный салат, богатый белком и полезными жирами",
            ingredients: "Киноа, авокадо, помидоры, огурцы, оливковое масло, лимон",
            carbohydrates: 40,
            fat: 20,
            protein: 10,
            servings: 2,
            category: "Обед",
            instructions: """
            1. Отварите киноа до готовности.
            2. Нарежьте авокадо, помидоры и огурцы.
            3. Смешайте киноа с нарезанными овощами.
            4. Заправьте оливковым маслом и лимонным соком.
            5. Перемешайте и подавайте.
            """
        )

        CoreDataeManager.shared.createRecipe(
            name: "Томатный суп с чечевицей",
            photo: "soup",
            calories: 300,
            cookingTime: 25,
            description: "Питательный суп, богатый белком и клетчаткой",
            ingredients: "Чечевица, томаты, лук, чеснок, оливковое масло, специи",
            carbohydrates: 45,
            fat: 5,
            protein: 15,
            servings: 4,
            category: "Ужин",
            instructions: """
            1. Обжарьте лук и чеснок до золотистого цвета.
            2. Добавьте томаты и чечевицу, залейте водой и доведите до кипения.
            3. Варите на среднем огне до готовности чечевицы.
            4. Приправьте специями и подавайте горячим.
            """
        )

        CoreDataeManager.shared.createRecipe(
            name: "Омлет с овощами и сыром",
            photo: "omelet",
            calories: 350,
            cookingTime: 10,
            description: "Сытный завтрак, богатый белком и витаминами",
            ingredients: "Яйца, молоко, шпинат, болгарский перец, сыр",
            carbohydrates: 10,
            fat: 25,
            protein: 20,
            servings: 1,
            category: "Завтрак",
            instructions: """
            1. Смешайте яйца с молоком до однородной массы.
            2. Обжарьте шпинат и болгарский перец до мягкости.
            3. Вылейте яичную смесь на сковороду.
            4. Добавьте обжаренные овощи и сыр, готовьте до готовности омлета.
            """
        )

        CoreDataeManager.shared.createRecipe(
            name: "Смузи с ягодами и овсянкой",
            photo: "berry_smoothie",
            calories: 200,
            cookingTime: 5,
            description: "Освежающий напиток, богатый антиоксидантами и клетчаткой",
            ingredients: "Ягоды, овсянка, йогурт, мед, молоко",
            carbohydrates: 35,
            fat: 5,
            protein: 10,
            servings: 1,
            category: "Завтрак",
            instructions: """
            1. Смешайте все ингредиенты в блендере.
            2. Перемешайте до однородной массы.
            3. Перелейте в стакан и подавайте.
            """
        )

        CoreDataeManager.shared.createRecipe(
            name: "Запеченная курица с овощами",
            photo: "roast_chicken",
            calories: 500,
            cookingTime: 45,
            description: "Сытный ужин с высоким содержанием белка и витаминов",
            ingredients: "Курица, картофель, морковь, брокколи, оливковое масло",
            carbohydrates: 50,
            fat: 20,
            protein: 30,
            servings: 3,
            category: "Ужин",
            instructions: """
            1. Разогрейте духовку до 200°C.
            2. Нарежьте картофель и морковь кубиками.
            3. Выложите курицу, картофель и морковь на противень.
            4. Полейте оливковым маслом и приправьте по вкусу.
            5. Запекайте в духовке 35 минут.
            6. Добавьте брокколи и запекайте еще 10 минут.
            7. Подавайте горячим.
            """
        )

        CoreDataeManager.shared.createRecipe(
            name: "Паста с овощами и сыром фета",
            photo: "pasta",
            calories: 450,
            cookingTime: 20,
            description: "Вкусный обед с сочетанием углеводов, белков и жиров",
            ingredients: "Паста, помидоры, шпинат, сыр фета, оливковое масло",
            carbohydrates: 60,
            fat: 15,
            protein: 15,
            servings: 2,
            category: "Обед",
            instructions: """
            1. Отварите пасту до готовности.
            2. Обжарьте шпинат и нарезанные помидоры на оливковом масле.
            3. Добавьте пасту к овощам и хорошо перемешайте.
            4. Посыпьте раскрошенным сыром фета и подавайте.
            """
        )
    }
}
        


