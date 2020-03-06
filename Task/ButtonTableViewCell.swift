//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by Jordan Furr on 3/5/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit
protocol ButtonTableViewCellDelegate: class{
    func tappedButton(for cell: ButtonTableViewCell)
}
class ButtonTableViewCell: UITableViewCell {

    var task: Task?
    
    weak var delegate: ButtonTableViewCellDelegate?
    @IBOutlet weak var checkButton: UIButton!
    @IBAction func buttonTapped(_ sender: Any) {
        delegate?.tappedButton(for: self)
    }
    
    @IBOutlet weak var labelText: UILabel!
    func setTask(task: Task, _isComplete: Bool){
        self.task = task
        updateUI(_isComplete: _isComplete)
    }
    
    @objc func updateUI(_isComplete: Bool){
        guard let task = task else {
            return }
        labelText.text = task.name
        updateButton(iscomplete: _isComplete)
    }
    
    func updateButton(iscomplete: Bool){
        if iscomplete {
            checkButton.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
        } else {
            checkButton.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
        }
    }
}
