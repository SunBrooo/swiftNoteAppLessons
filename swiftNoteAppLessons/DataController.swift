//
//  DataController.swift
//  swiftNoteAppLessons
//
//  Created by mac on 24.09.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation

enum ModNote {
    case create
    case edit
    case del
}

protocol DataControllerDelegate {
    func dataSourceChanged(dataSource: [Note]?, error: Error?)
}

class DataController {
    var notes:[Note] = []
    
    var delegate: DataControllerDelegate?
    
    func getNote(){
        self.delegate?.dataSourceChanged(dataSource: self.notes, error: nil)
    }
    
    func modify(note:Note, task: ModNote){
       
            switch task {
                
            case .create:
                notes.append(note)
            case .edit:
                if let index = notes.index(where: {$0 == note}){ // верни нам индекс, который равен заметке note
                    notes[index] = note
                    
                }
            case .del:
                if let index = notes.index(where: {$0 == note}){ // верни нам индекс, который равен заметке note
                    notes.remove(at: index)
                  }
            }
        
            self.delegate?.dataSourceChanged(dataSource: notes, error: nil)
       
    }
}
