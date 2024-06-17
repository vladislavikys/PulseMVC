//
//  StorageManager.swift
//  PulseMVC
//
//  Created by Влад on 28.02.24.
//

import UIKit
import CoreData

//MARK: - CRUD

public final class CoreDataeManager: NSObject {
    
    public static let shared = CoreDataeManager()
    private override init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    public var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    // Получение или создание единственного экземпляра Profile
        private func getOrCreateProfile() -> Profile {
            // Создаем запрос на выборку для сущности Profile
            let fetchRequest: NSFetchRequest<Profile> = Profile.fetchRequest()
            do {
                // Пытаемся выполнить запрос к контексту и получить массив профилей
                let results = try context.fetch(fetchRequest)
                // Если в базе данных уже есть профиль, возвращаем первый найденный
                if let existingProfile = results.first {
                    return existingProfile
                }
            } catch {
                print("Ошибка при извлечении профиля: \(error.localizedDescription)")
            }
            
            // Если существующий профиль не был найден, создаем новый экземпляр профиля в контексте
            let newProfile = Profile(context: context)
            return newProfile
        }
    
    // Объединенный метод для обновления свойств профиля
    public func updateProfile(units: String? = nil, gender: String? = nil, age: Int? = nil, weight: Int? = nil, height: Int? = nil, bpmAverage: Int? = nil, analyze: String? = nil) {
            let profile = getOrCreateProfile()
            
            //обновляем если передали
            if let units = units {
                profile.units = units
            }
            if let gender = gender {
                profile.gender = gender
            }
            if let age = age {
                profile.age = Int16(age)
            }
            if let weight = weight {
                profile.weight = Int16(weight)
            }
            if let height = height {
                profile.height = Int16(height)
            }
            if let bpmAverage = bpmAverage {
                profile.bpm = Int16(bpmAverage)
            }
            if let analyze = analyze {
                profile.analyze = analyze
            }
        
        saveContextProfile()
        }
    // Сохранение контекста с обработкой ошибок
         func saveContextProfile() {
            do {
                try context.save()
                print("Profile saved successfully.")
            } catch {
                print("Error saving Profile: \(error.localizedDescription)")
            }
        }
    //read
    public func fetchProfile() -> Profile?{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        do {
            let profile = try? context.fetch(fetchRequest) as? [Profile]
            return profile?.first
        } catch let error as NSError {
            print("Ошибка при извлечении данных: \(error), \(error.userInfo)")
            return nil
        }
    }
    
    //delete
    public func deleteAllProfile(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        do {
            let profile = try? context.fetch(fetchRequest) as? [Profile]
            profile?.forEach{context.delete($0)}
        }
        appDelegate.saveContext()
    }
}

extension CoreDataeManager {
    // Проверка  рецепта в базе данных
        func checkIfRecipeExists(name: String) -> Bool {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipes")
            fetchRequest.predicate = NSPredicate(format: "name == %@", name)
            
            do {
                let count = try context.count(for: fetchRequest)
                return count > 0 //  true, если рецепт найден
            } catch {
                print("Error checking recipe existence: \(error.localizedDescription)")
                return false
            }
        }
    // создания нового рецепта
    func createRecipe(name: String, photo: String, calories: Int16,
                          cookingTime: Int16, description: String?, ingredients: String?, carbohydrates: Int16,
                          fat: Int16, protein: Int16, servings: Int16, category: String?) {
        
            if checkIfRecipeExists(name: name) {
                print("Recipe with name '\(name)' already exists")
                return
            }
            
            let newRecipe = Recipes(context: context)
            newRecipe.name = name
            newRecipe.photo = photo
            newRecipe.calories = calories
            newRecipe.cooking_time = cookingTime
            newRecipe.descript = description
            newRecipe.ingredients = ingredients
            newRecipe.carbohydrates = carbohydrates
            newRecipe.fat = fat
            newRecipe.protein = protein
            newRecipe.servings = servings
            newRecipe.category = category
            
            saveContextRecepies()
        }
    
    private func saveContextRecepies() {
        do {
            try context.save()
            print("Recipe saved successfully.")
        } catch {
            print("Error saving recipe: \(error.localizedDescription)")
        }
    }
    //delete
    public func deleteAllRecepies(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipes")
        do {
            let profile = try? context.fetch(fetchRequest) as? [Recipes]
            profile?.forEach{context.delete($0)}
        }
        appDelegate.saveContext()
    }
    
    //получения всех рецептов
    public func fetchAllRecipes() -> [Recipes]?{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipes")
        do {
            let recipes = try? context.fetch(fetchRequest) as? [Recipes]
            return recipes
        } catch let error as NSError {
            print("Error fetching recipes: \(error), \(error.userInfo)")
            return nil
        }
    }
    
    public func printAllRecipes() {
        if let recipes = fetchAllRecipes() {
            var index = 1
            for recipe in recipes {
                print("\(index) - \(recipe.name ?? "No name")")
                index += 1
            }
        } else {
            print("No recipes found")
        }
    }
}
