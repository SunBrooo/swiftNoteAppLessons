//
//  ViewController.swift
//  swiftNoteAppLessons
//
//  Created by mac on 19.09.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {
    
    var notesArray = [String]()
    
    @IBOutlet weak var notesTable: UITableView!
    
    @IBOutlet weak var notesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }


    @IBAction func composeButton(_ sender: Any) {
        
      addNote()
     
    }
    
    func addNote() {
        
        let note = "note" + "\(notesArray.count + 1)"
        notesArray.append(note)
        notesTable.reloadData()
    }
    
    func delNote(index: Int) {
        notesArray.remove(at: index)
        
    }
}

extension NotesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let notesCount = notesArray.count
        
        if notesCount > 0 {
            notesLabel.isHidden = true
        } else {
           notesLabel.isHidden = false
        }
       
        return notesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = notesArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            delNote(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // добавляем футер
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}
