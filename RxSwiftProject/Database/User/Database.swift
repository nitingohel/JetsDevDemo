//
//  Database.swift
//  RxSwiftProject
//
//  Created by Nitin Gohel on 01/10/21.
//

import UIKit
import CoreData

class Database: NSObject {
    var container: NSPersistentContainer!
    static let shared = Database()
    override init() {
        super.init()
        self.setup()
    }
}

extension Database {
    fileprivate func setup() {
        self.container = NSPersistentContainer(name: "Database")
        self.container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                print("\(error.localizedDescription)")
            }
        }
    }
    
    func saveContext() {
        if self.container.viewContext.hasChanges {
            do {
                try self.container.viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func saveUser(_ user: Dictionary<String, Any>) -> User {
        let userID = user["userId"] as? Int ?? 0
        if let userObj = self.checkAvailableUser(userID) {
            userObj.setJson(user)
            self.saveContext()
            return userObj
        } else {
            let userObj = User(context: self.container.viewContext)
            userObj.setJson(user)
            self.saveContext()
            return userObj
        }
    }
    
    func checkAvailableUser(_ userID: Int) -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        let predicate = NSPredicate(format: "userID == %d", userID)
        request.predicate = predicate
        do {
            let userData = try self.container.viewContext.fetch(request).first
            self.saveContext()
            return userData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
