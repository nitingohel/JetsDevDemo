//
//  User+CoreDataProperties.swift
//  RxSwiftProject
//
//  Created by Nitin Gohel on 01/10/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var userID: Int64
    @NSManaged public var created_At: Date?
    @NSManaged public var userName: String?

}

extension User : Identifiable {

}
