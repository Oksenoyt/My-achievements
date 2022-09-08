//
//  StorageManager .swift
//  My achievements
//
//  Created by Elenka on 05.09.2022.
//

import Foundation
import CoreData

class StorageManager {
    static let shared = StorageManager()
    
    // MARK: - Core Data stack
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyAchievements")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private let viewContext: NSManagedObjectContext
    
    private init() {
        viewContext = persistentContainer.viewContext
    }
    
    // MARK: - CRUD
    func create(country: String) {
        let countryData = CountryData(context: viewContext)
        countryData.nameData = country
//        countryData.visitedData = false
        saveContext()
    }
    
    func fetchData(currentCountry: String, completion: (Result<[CountryData], Error>) -> Void) {
        let fetchRequest = CountryData.fetchRequest()
        do {
            fetchRequest.predicate = NSPredicate(
//                format: "name LIKE %@", "Robert"
                format: "nameData CONTAINS %@", currentCountry
            )
            let country = try viewContext.fetch(fetchRequest)
            print(country)
            completion(.success(country))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func update(country: String, visitedChange: Bool) {
        print(country, visitedChange)
//        CountryData.d
//        CountryData.setValue(visitedChange, forKey: country)
        saveContext()
    }
    
    // MARK: - Core Data Saving support
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

