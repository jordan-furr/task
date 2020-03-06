//
//  TaskTableViewController.swift
//  Task
//
//  Created by Jordan Furr on 3/4/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class TaskTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? ButtonTableViewCell else { return UITableViewCell()}
        
        let task = TaskController.shared.tasks[indexPath.row]
        cell.setTask(task: task, _isComplete: task.isComplete)
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = TaskController.shared.tasks[indexPath.row]
            TaskController.shared.remove(task: task)
            tableView.deleteRows(at: [indexPath], with: .left)
            
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView"{
            if let destinationVC = segue.destination as? DetailTableViewController {
                if let index = tableView.indexPathForSelectedRow{
                    let task = TaskController.shared.tasks[index.row]
                    destinationVC.task = task
                    if let due = task.due {
                        destinationVC.dueDate = due
                    }
                }
            }
        }
    }
}

extension TaskTableViewController: ButtonTableViewCellDelegate {
    func tappedButton(for cell: ButtonTableViewCell) {
        guard let task = cell.task else {return}
        TaskController.shared.toggleisComplete(task: task)
        cell.updateButton(iscomplete: task.isComplete)
    }
}
