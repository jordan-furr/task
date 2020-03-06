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
    var tasks: [Task] = []
    
    init() {
        tasks = fetchRequest()
    }
    
    func fetchRequest() -> [Task] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        return (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    
    //MARK: CRUD
    
    func add(taskWithName name: String, notes: String?, due: Date?){
        Task(name: name, notes: notes, due: due, isComplete: false)
        saveToPersistentStore()
        tasks = fetchRequest()
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?){
        if let index = tasks.firstIndex(of: task){
            tasks[index].name = name
            tasks[index].notes = notes
            tasks[index].due = due
        }
        saveToPersistentStore()
        tasks = fetchRequest()
    }
    
    func remove(task: Task) {
        if let index = tasks.firstIndex(of: task){
            tasks.remove(at: index)
            saveToPersistentStore()
            tasks = fetchRequest()
        }
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
