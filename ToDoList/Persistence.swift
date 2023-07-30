//
//  Persistence.swift
//  ToDoList
//
//  Created by Joseph William Santoso on 29/07/23.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    let container: NSPersistentContainer
    
    // Updated initializer of PersistenceController class
    init(inMemory: Bool = false) {
        guard let modelURL = Bundle.main.url(forResource: "ToDoList", withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Could not find Core Data model.")
        }
        
        container = NSPersistentCloudKitContainer(name: "ToDoList", managedObjectModel: model)
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Could not load Core Data persistence stores:", error.localizedDescription)
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    func saveChanges() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Could not save changes to Core Data.", error.localizedDescription)
            }
        }
    }
    
    func create(taskName: String, taskDesc: String, taskDue: Date) {
        // create a NSManagedObject, will be saved to DB later
        let entity = TaskItem(context: container.viewContext)
        // attach value to the entity’s attributes
        entity.taskName = taskName
        entity.taskDesc = taskDesc
        entity.taskDue = Date()
        entity.taskCreated = Date()
        // save changes to DB
        saveChanges()
    }
    
    // function to fetch notes from DB
    func read(predicateFormat: String? = nil, fetchLimit: Int? = nil) -> [TaskItem] {
        // create a temp array to save fetched notes
        var results: [TaskItem] = []
        // initialize the fetch request
        let request = NSFetchRequest<TaskItem>(entityName: "TaskItem")
        
        // define filter and/or limit if needed
        if predicateFormat != nil {
            request.predicate = NSPredicate(format: predicateFormat!)
        }
        if fetchLimit != nil {
            request.fetchLimit = fetchLimit!
        }
        
        // fetch with the request
        do {
            results = try container.viewContext.fetch(request)
        } catch let error as NSError {
            print("Error fetching data from Core Data:", error.localizedDescription)
        }
        
        // return results
        return results
    }
    
    func update(entity: TaskItem, taskName: String? = nil, taskDesc: String? = nil, taskDue: Date? = Date()) {
        // create a temp var to tell if an attribute is changed
        var hasChanges: Bool = false
        
        // update the attributes if a value is passed into the function
        if taskName != nil {
            entity.taskName = taskName!
            hasChanges = true
        }
        if taskDesc != nil {
            entity.taskDesc = taskDesc!
            hasChanges = true
        }
        if taskDue != nil {
            entity.taskDue = taskDue!
            hasChanges = true
        }
        
        // save changes if any
        if hasChanges {
            saveChanges()
        }
    }
    
    // function to delete a task
    func delete(_ entity: TaskItem) {
        container.viewContext.delete(entity)
        saveChanges()
    }
    
}
