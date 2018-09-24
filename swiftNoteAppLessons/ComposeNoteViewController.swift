//
//  ComposeNoteViewController.swift
//  swiftNoteAppLessons
//
//  Created by mac on 21.09.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class ComposeNoteViewController: UIViewController {
    
    public var dataController: DataController!
    public var note: Note?

    @IBOutlet weak var noteTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let note = self.note {
            noteTextView.text = note.text
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if noteTextView.text.count > 0 {
            
            let task: ModNote
            var currentNote: Note
            if let note = self.note {
                task = .edit
                currentNote = Note(text: noteTextView.text, noteID: note.noteID)
            } else {
                task = .create
                
               currentNote = Note(text: noteTextView.text, noteID: "")
            }
            dataController.modify(note: currentNote, task: task)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
