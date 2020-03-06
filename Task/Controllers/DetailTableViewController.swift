//
//  DetailTableViewController.swift
//  Task
//
//  Created by Jordan Furr on 3/4/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {

    var task: Task? {
        didSet {
        //    updateViews()
        }
    }
    var dueDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        dateTextView.inputView = dueDatePicker
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateViews()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    @IBAction func userTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    

    // MARK: - IB OUTLETS & ACTIONS
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var dateTextView: UITextField!
    
    @IBOutlet weak var notesText: UITextView!
    @IBOutlet var dueDatePicker: UIDatePicker!
   
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        dateTextView.text = dueDatePicker.date.stringValue()
        dueDate = dueDatePicker.date
        if let task = task { TaskController.shared.update(task: task, name: task.name ?? "", notes: task.notes, due: dueDate)
        }
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        if let name = nameText.text {
            if let task = task {
                TaskController.shared.update(task: task, name: name, notes: notesText.text ?? "", due: dueDate)
            } else {
                TaskController.shared.add(taskWithName: name, notes: notesText.text ?? "", due: dueDate)
            }
        }
         navigationController?.popViewController(animated: true)
    }
    @IBAction func cancelTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

    // MARK: - Helper Functions
    func updateViews(){
        if let task = task {
            let name = task.name
            nameText.text = name ?? "Untitled"
            notesText.text = task.notes ?? ""
            if let due = dueDate {
                dateTextView.text = due.stringValue()
            } else {
                dateTextView.text = "No due date"
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section) {
        case 0:
            return "Name"
        case 1:
            return "Due"
        default:
            return "Notes"
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
}
