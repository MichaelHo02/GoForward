//
//  DataController.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import Foundation
import CoreData

final class DataController {
    let persistentContainer: NSPersistentContainer
    static let shared = DataController()
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func getAllUsers() -> [User] {
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print("Cannot save")
        }
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Model")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
}
