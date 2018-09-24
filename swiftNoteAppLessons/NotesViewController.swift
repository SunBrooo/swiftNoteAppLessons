//
//  ViewController.swift
//  swiftNoteAppLessons
//
//  Created by mac on 19.09.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {
    
    var notes = [Note]()
    
    let dataController = DataController()
    
    @IBOutlet weak var notesTable: UITableView!
    
    @IBOutlet weak var notesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dataController.delegate = self
        
    }

    @IBAction func composeButton(_ sender: Any) {
        performSegue(withIdentifier: "EditNoteSegue", sender: nil)
    }
    
}

extension NotesViewController: UITableViewDataSource, UITableViewDelegate, DataControllerDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let notesCount = notes.count
        
        if notesCount > 0 {
            notesLabel.isHidden = true
        } else {
           notesLabel.isHidden = false
        }
       
        return notesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as UITableViewCell
        
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.text
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
           dataController.modify(note: notes[indexPath.row], task: .del)
        }
    }
    
    // переход segue по нажатию на ячейку таблицы
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "EditNoteSegue", sender: indexPath.row)
    }
    
    // добавляем футер
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func dataSourceChanged(dataSource: [Note]?, error: Error?) {
       // распаковываем массив
        if let notes = dataSource {
            self.notes = notes
            notesTable.reloadData()
        }
    }
    // функция вызывается, каждый раз, когда хотим перейти на новый класс
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let composeVC = segue.destination as? ComposeNoteViewController {
        if segue.identifier == "EditNoteSegue" {
             composeVC.dataController = dataController
            if let index  = sender as? Int {
                composeVC.note = notes[index]
            }
        }
         }
    }
    
}
