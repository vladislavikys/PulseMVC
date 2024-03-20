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
    //
    // Получение или создание единственного экземпляра Profile
    //нашел в сети но я понимаю как работает либо его понять
    //либо  перепсать совими словами
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
        public func updateProfile(units: String? = nil, gender: String? = nil, age: Int? = nil, weight: Int? = nil, height: Int? = nil) {
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
            
            appDelegate.saveContext()
        }
    // Сохранение контекста с обработкой ошибок
        private func saveContext() {
            do {
                try context.save()
            } catch {
                print("Ошибка при сохранении контекста: \(error.localizedDescription)")
            }
        }
    //
    
    
    
    
    //save
    public func createUnits(units: String){
        guard let unitsEntityDescription = NSEntityDescription.entity(forEntityName: "Profile", in: context) else {return}
        let profile = Profile(entity: unitsEntityDescription, insertInto: context)
        profile.units = units
        appDelegate.saveContext()
    }
    public func createGender(gender: String){
        guard let unitsEntityDescription = NSEntityDescription.entity(forEntityName: "Profile", in: context) else {return}
        let profile = Profile(entity: unitsEntityDescription, insertInto: context)
        profile.gender = gender
        appDelegate.saveContext()
    }
    public func createAge(age: Int){
        guard let unitsEntityDescription = NSEntityDescription.entity(forEntityName: "Profile", in: context) else {return}
        let profile = Profile(entity: unitsEntityDescription, insertInto: context)
        profile.age = Int16(age)
        appDelegate.saveContext()
    }
    public func createWeight(weight: Int){
        guard let unitsEntityDescription = NSEntityDescription.entity(forEntityName: "Profile", in: context) else {return}
        let profile = Profile(entity: unitsEntityDescription, insertInto: context)
        profile.weight = Int16(weight)
        appDelegate.saveContext()
    }
    public func createHeight(height: Int){
        guard let unitsEntityDescription = NSEntityDescription.entity(forEntityName: "Profile", in: context) else {return}
        let profile = Profile(entity: unitsEntityDescription, insertInto: context)
        profile.height = Int16(height)
        appDelegate.saveContext()
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
    public func deleteAll(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        do {
            let profile = try? context.fetch(fetchRequest) as? [Profile]
            profile?.forEach{context.delete($0)}
        }
        appDelegate.saveContext()
    }
    
    //delete attribute internete
    public func deleteProfile(byAttribute attribute: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        // Удаление происходит по наличию атрибута, без учёта его значения.
        // Важно: Убедитесь, что атрибут существует в вашей модели.
        fetchRequest.predicate = NSPredicate(format: "%K != nil", attribute)

        do {
            let results = try context.fetch(fetchRequest) as? [Profile]
            results?.forEach { profile in
                context.delete(profile)
            }
            appDelegate.saveContext()
            print("Удаление завершено. Удалены все профили, где атрибут \(attribute) присутствует.")
        } catch let error as NSError {
            print("Ошибка при удалении: \(error), \(error.userInfo)")
        }
    }

    
}

