//
//  Note.swift
//  swiftNoteAppLessons
//
//  Created by mac on 21.09.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation

public struct Note {
    
    public let text: String
    public let noteID: String
    
    public init(text: String, noteID: String ) {
        self.text = text
        self.noteID = noteID
    }
    
    static func == (left: Note, right: Note) -> Bool {
        return left.noteID == right.noteID
    }
}
