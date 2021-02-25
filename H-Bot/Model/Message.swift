//
//  Message.swift
//  H-BotWj2
//
//  Created by Wenjing Zhang on 2021-02-23.
//

import SwiftUI
import Firebase
import Combine
import FirebaseFirestoreSwift

struct Message: Identifiable,Codable {
  
    //DocuentID will assumes firestore doc id as id while reading and viceversa while writing...
    @DocumentID var id : String?
    var msg : String = ""
    var date : Timestamp? = nil
    
    enum Keys : String,CodingKey{
        //these keys are firestore key values...
        //if the key value is different means we must specify here....
        case id
        case msg = "message "
        case date
    }
        //func writeMessage(){
        
        //}
        
        
        //func readMessage(){
        
        //}
}

