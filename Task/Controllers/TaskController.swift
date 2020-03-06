//
//  TaskController.swift
//  Task
//
//  Created by Jordan Furr on 3/4/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import Foundation
import CoreData


class TaskController {
    
    //MARK: Singleton
    static let shared = TaskController()
    
    //MARK: Source of Truth
    let fetchedResultsController: NSFetchedResultsController<Task>  = {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "isComplete", ascending: false), NSSortDescriptor(key: "due", ascending: false)]
        let resultsController: NSFetchedResultsController<Task> = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isComplete", cacheName: nil)
        return resultsController
    }()
    
    init() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Error")
        }
    }
    
    //MARK: CRUD
    
    func add(taskWithName name: String, notes: String?, due: Date?){
        Task(name: name, notes: notes, due: due, isComplete: false)
        saveToPersistentStore()
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?){
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStore()
    }
    
    func remove(task: Task) {
        CoreDataStack.context.delete(task)
            saveToPersistentStore()
        
    }
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("There was an error saving the data!!!!! \(#function) \(error.localizedDescription)")
        }
    }
    
    func toggleisComplete(task: Task){
        task.isComplete = !task.isComplete
        saveToPersistentStore()
        
    }
}
