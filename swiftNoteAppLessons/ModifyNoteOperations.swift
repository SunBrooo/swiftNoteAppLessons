//
//  ModifyNoteOperations.swift
//  swiftNoteAppLessons
//
//  Created by mac on 25.09.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation

class ModifyNoteOperations: Operation {
    let modification: ModNote
    let note: Note
    
    var Error: Error?
    
    var currentState: Bool = false
    
    override var isFinished: Bool {
        get {
            return currentState
        }
        
        set (newValue) {
            willChangeValue(forKey: "isFinished")
            currentState = newValue
            didChangeValue(forKey: "isFinished")
        }
    }
    
    init (modification: ModNote, note: Note) {
        self.modification = modification
        self.note = note
    }
    
    override func main(){
        if isCancelled {
            return
        }
        
        let requestMethod: String
        let identifier: String
        let requestData: Data?
    
        switch modification {
        case .create:
            requestMethod = "PUT"
            identifier = UUID().uuidString
            
            let note = ["notetext": self.note.text]
            
            requestData = try! JSONSerialization.data(withJSONObject: note, options: JSONSerialization.WritingOptions.init(rawValue: 0))
            
        case .edit:
            
            requestMethod = "PUT"
            identifier = self.note.noteID
            
            let note = ["notetext": self.note.text]
            
            requestData = try! JSONSerialization.data(withJSONObject: note, options: JSONSerialization.WritingOptions.init(rawValue: 0))
            
        case .del:
            
            requestMethod = "Delete"
            identifier = self.note.noteID
            requestData = nil
        }
    
        let request = NSMutableURLRequest(url: NSURL(string: "https://BgvaS8m3c:7f72f17f-7a65-45e4-8ae3-b18239500613@scalr.api.appbase.io/mynotesapp/note/\(identifier)")! as URL)
        
        
        request.httpBody = requestData
        request.httpMethod = requestMethod
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            do {
                let str = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) as! [String: AnyObject]
                print(str)
            } catch {
                print("json parse error: \(error)")
            }
            self.isFinished = true
        }
        
        task.resume()
        
    }
}
