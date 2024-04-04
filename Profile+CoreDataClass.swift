//
//  Profile+CoreDataClass.swift
//  
//
//  Created by Влад on 4.03.24.
//
//

import Foundation
import CoreData

@objc(Profile)
public class Profile: NSManagedObject {

}

extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var gender: String?
    @NSManaged public var height: Int16
    @NSManaged public var weight: Int16
    @NSManaged public var age: Int16
    @NSManaged public var units: String?
    @NSManaged public var bpm: Int16
    @NSManaged public var analyze: String?
    
}

