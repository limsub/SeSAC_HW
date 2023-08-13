//
//  TodoTableViewCell.swift
//  0801pj
//
//  Created by 임승섭 on 2023/08/01.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    
    var specialCallBackMethod: (() -> Void)?
    var doneCallBackMethod: (() -> Void)?
    
    
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var specialButton: UIButton!
    @IBOutlet var todoTextView: UITextView!
    
    
    func designCell(_ sender: ToDo) {
        
        doneButton.setImage(UIImage(systemName: (sender.done)
                                    ? "checkmark.square.fill"
                                    : "checkmark.square")
                                    , for: .normal)
        specialButton.setImage(UIImage(systemName: (sender.special)
                                      ? "star.fill"
                                       : "star")
                               , for: .normal)
        
        todoTextView.text = sender.main
    }
    
    
    
    @IBAction func specialButtonTapped(_ sender: UIButton) {
        specialCallBackMethod?()
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        doneCallBackMethod?()
    }
    
}
