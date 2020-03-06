//
//  Task+Convenience.swift
//  Task
//
//  Created by Jordan Furr on 3/4/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    
    @discardableResult
    convenience init(name: String, notes: String?, due: Date?, isComplete: Bool?, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.name = name
        self.notes = notes ?? ""
        self.due = due ?? nil
        self.isComplete = isComplete ?? false
    }
}
