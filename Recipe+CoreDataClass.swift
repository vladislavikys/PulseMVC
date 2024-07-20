import Foundation
import CoreData

@objc(Recipes)
public class Recipes: NSManagedObject {

}

extension Recipes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipes> {
        return NSFetchRequest<Recipes>(entityName: "Recipes")
    }

    @NSManaged public var calories: Int16
    @NSManaged public var carbohydrates: Int16
    @NSManaged public var cooking_time: Int16
    @NSManaged public var descript: String?
    @NSManaged public var fat: Int16
    @NSManaged public var ingredients: String?
    @NSManaged public var ingredientDetails: [String: String]?
    @NSManaged public var name: String?
    @NSManaged public var photo: String?
    @NSManaged public var protein: Int16
    @NSManaged public var servings: Int16
    @NSManaged public var category: String?
    @NSManaged public var instructions: String?

}
