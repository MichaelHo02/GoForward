/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Ho Le Minh Thach
 ID: s3877980
 Created  date: 27/08/2022
 Last modified: 27/08/2022
 Learning from Hacking with Swift to implement MVVM, and the usage of CoreData
 Hudson, P. (n.d.). The 100 days of Swiftui. Hacking with Swift. Retrieved July 30, 2022, from https://www.hackingwithswift.com/100/swiftui
*/

import Foundation
import CoreData

/// This controller responsible for connecting with the core data with singleton
final class DataController {
    let persistentContainer: NSPersistentContainer
    static let shared = DataController()
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    /// This function will get all the users sorted from greatest score to smallest score
    /// - Returns: list of users
    func getAllUsers() -> [User] {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "score", ascending: false)]
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    /// This function will save the data to core data
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print("Cannot save")
        }
    }
    
    /// Connect to core data
    private init() {
        persistentContainer = NSPersistentContainer(name: "Model")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
}
