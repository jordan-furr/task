//
//  NewTaskTableViewController.swift
//  Task
//
//  Created by Jordan Furr on 3/5/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit
import CoreData

class NewTaskTableViewController: UITableViewController, NSFetchedResultsControllerDelegate{

 override func viewDidLoad() {
       super.viewDidLoad()
    TaskController.shared.fetchedResultsController.delegate = self
     
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return TaskController.shared.fetchedResultsController.sections?.count ?? 0
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? ButtonTableViewCell else { return UITableViewCell()}
        
        let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
        cell.setTask(task: task, _isComplete: task.isComplete)
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
            TaskController.shared.remove(task: task)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         switch(section) {
               case 0:
                   return "Finished"
              default:
                    return "Unfinished"
        }
    }
    //mark: ns fetched
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            guard let indexPath = indexPath else {break}
        tableView.deleteRows(at: [indexPath], with: .automatic)
        case .insert:
            guard let indexPath = newIndexPath else {break}
            tableView.insertRows(at: [indexPath], with: .automatic)
        case .move:
             guard let oldindexPath = indexPath, let newIndexPath = newIndexPath else {break}
             tableView.moveRow(at: oldindexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else {break}
            tableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            print("error")
        }
    }
    
   func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
       switch type {
       case .delete:
           tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
       case .insert:
           tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
       case .move:
           break
       case .update:
           break
       @unknown default:
           fatalError()
       }
   }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView"{
            if let destinationVC = segue.destination as? DetailTableViewController {
                if let index = tableView.indexPathForSelectedRow {
                    let task = TaskController.shared.fetchedResultsController.object(at: index)
                    destinationVC.task = task
                    if let due = task.due {
                        destinationVC.dueDate = due
                    }
                }
            }
        }
    }
}

extension NewTaskTableViewController: ButtonTableViewCellDelegate {
    func tappedButton(for cell: ButtonTableViewCell) {
        guard let task = cell.task else {return}
        TaskController.shared.toggleisComplete(task: task)
        cell.updateButton(iscomplete: task.isComplete)
        tableView.reloadData()
    }
}
