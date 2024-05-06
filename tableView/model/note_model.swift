//
//  note_model.swift
//  tableView
//
//  Created by Sauth.P on 4/5/24.
//
// Note.swift
import Foundation
//import SwiftProtobuf

// Define a struct to represent a Note
//@objcMembers // Allow Objective-C compatibility
public struct NoteModel { // Codable for JSON encoding/decoding, Message for Protobuf compatibility

//  public static func == (lhs: Note, rhs: Note) -> Bool {
//    return lhs.id == rhs.id
//  }


  public var id: Int = 0
  public var title: String = ""
  public var content: String = ""
    // nullable image
    public var image: String = ""
//  public var user: ObjectId // Reference to the User model

  public var isInitialized: Bool {
    get { !title.isEmpty && !content.isEmpty }
    set {
        
    }
  }
}
