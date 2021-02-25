//
//  SwiftUIView.swift
//  H-Bot
//
//  Created by Wenjing Zhang on 2021-02-25.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class MainViewModel: ObservableObject{
    
    @Published var messages : [Message] = []
    
    let ref = Firestore.firestore()
    
    func getAllMessages(){
        //sorting messages...
        ref.collection("Messages").order(by: "date",descending: false).addSnapshotListener{
            (snap, err) in
            
            guard let docs = snap else{return}
            
            docs.documentChanges.forEach {(doc) in
                let message = try! doc.document.data(as: Message.self)
                 
                if doc.type == .added{
                    self.messages.append(message!)
                    
                }
                if doc.type == .modified{
                    //Data Modified...
                }
                //self.messages.append(message!)
            }
        }
    }
    
    // closure or completion block....
   /* func addMessage(message: Message,completion: @escaping(Bool)->()){
        
        do{
            
            let _ = try
                ref.collection("Messages").addDocument(from: message){
                    (error) in
                    
                    if error != nil{
                        completion(false)
                        return
                    }
                    completion(true)
                }
        }
        catch{
            
        }
    }*/
}


