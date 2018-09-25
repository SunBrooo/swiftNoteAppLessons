//
//  GetNoteOperations.swift
//  swiftNoteAppLessons
//
//  Created by mac on 25.09.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation

class GetNotesOperations: Operation {
    var data: Data?
    var error: Error?
    
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
    
    override func main(){
        
      let request = NSMutableURLRequest(url: NSURL(string: "https://BgvaS8m3c:7f72f17f-7a65-45e4-8ae3-b18239500613@scalr.api.appbase.io/mynotesapp/note/_search")! as URL)
       
        request.httpMethod = "POST"
        
        let query = ["query":[]]
        
        request.httpBody = try! JSONSerialization.data(withJSONObject: query, options: JSONSerialization.WritingOptions.init(rawValue: 0))
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
           self.data = data
           self.error = error
            print("GOT NOTES = \(data)")
            self.isFinished = true
        }
        
        task.resume()
    }
}
