import UIKit
import CoreData

// MARK: - CRUD

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
        let fetchRequest: NSFetchRequest<Profile> = Profile.fetchRequest()
        do {
            let results = try context.fetch(fetchRequest)
            if let existingProfile = results.first {
                return existingProfile
            }
        } catch {
            print("Ошибка при извлечении профиля: \(error.localizedDescription)")
        }
        let newProfile = Profile(context: context)
        return newProfile
    }
    
    // Объединенный метод для обновления свойств профиля
    public func updateProfile(units: String? = nil, gender: String? = nil, age: Int? = nil, weight: Int? = nil, height: Int? = nil, bpmAverage: Int? = nil, analyze: String? = nil) {
        let profile = getOrCreateProfile()
        if let units = units {
            profile.units = units
        }
        if let gender = gender {
            profile.gender = gender
        }
        if let age = age {
            profile.age = Int16(age ?? 0)
        }
        if let weight = weight {
            profile.weight = Int16(weight ?? 0)
        }
        if let height = height {
            profile.height = Int16(height ?? 0)
        }
        if let bpmAverage = bpmAverage {
            profile.bpm = Int16(bpmAverage ?? 0)
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
    
    // Чтение профиля
    public func fetchProfile() -> Profile? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        do {
            let profile = try? context.fetch(fetchRequest) as? [Profile]
            return profile?.first
        } catch let error as NSError {
            print("Ошибка при извлечении данных: \(error), \(error.userInfo)")
            return nil
        }
    }
    
    // Удаление всех профилей
    public func deleteAllProfile() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        do {
            let profile = try? context.fetch(fetchRequest) as? [Profile]
            profile?.forEach { context.delete($0) }
        }
        appDelegate.saveContext()
        print("deleteAllProfile")
    }
}

extension CoreDataeManager {
    // Проверка рецепта в базе данных
    func checkIfRecipeExists(name: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipes")
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Error checking recipe existence: \(error.localizedDescription)")
            return false
        }
    }
    
    // Создание нового рецепта
    func createRecipe(name: String, photo: String, calories: Int16, cookingTime: Int16, description: String, ingredients: String, ingredientDetails: [String: String], carbohydrates: Int16, fat: Int16, protein: Int16, servings: Int16, category: String, instructions: String) {

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
        newRecipe.ingredientDetails = ingredientDetails
        newRecipe.carbohydrates = carbohydrates
        newRecipe.fat = fat
        newRecipe.protein = protein
        newRecipe.servings = servings
        newRecipe.category = category
        newRecipe.instructions = instructions

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
    
    // Удаление всех рецептов
    public func deleteAllRecepies() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipes")
        do {
            let recipes = try? context.fetch(fetchRequest) as? [Recipes]
            recipes?.forEach { context.delete($0) }
        }
        appDelegate.saveContext()
    }
    
    // Получение всех рецептов
    public func fetchAllRecipes() -> [Recipes]? {
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
