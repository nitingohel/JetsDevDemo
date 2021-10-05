//
//  User+CoreDataClass.swift
//  RxSwiftProject
//
//  Created by Nitin Gohel on 01/10/21.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {
    func setJson(_ json: Dictionary<String, Any>) {
        self.userID = json["userId"] as? Int64 ?? 0
        self.userName = json["userName"] as? String
        self.created_At = (json["created_at"] as? String ?? "").getDate()
    }
}
