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
    
    init() {
        //self.getAllMessages()
    }
    
    func getAllMessages(){
        //sorting messages...
        messages.removeAll()
        ref.collection("Messages").order(by: "date",descending: false).addSnapshotListener{ (snap, err) in
            guard let docs = snap else{return}
            docs.documentChanges.forEach {(doc) in
                print("1--->")
                print(doc.document.data())
                print("2--->")
                let message = try! doc.document.data(as: Message.self)
                
                if doc.type == .added{
                    self.messages.append(message!)
                }
                if doc.type == .modified{
                    //Data Modified...
                    for i in 0..<self.messages.count{
                        
                        if self.messages[i].id == message?.id!{
                            
                            self.messages[i] = message!
                        }
                    }
                }
            }
        }
    }
    
    // closure or completion block....
    func addMessage(message: Message,completion: @escaping(Bool)->()){
        do{
            let _ = try
                ref.collection("Messages").addDocument(from: message){ (error) in
                    if error != nil {
                        completion(false)
                        return
                    }
                    completion(true)
                }
        }
        catch{
            print(error.localizedDescription)
            completion(false)
        }
    }
    
    
    func deleteMessage(docId : Int){
        ref.collection("Messages").document(messages[docId].id!).delete{(error) in
            if error != nil{
                return
            }
            self.messages.remove(at: docId)
        }
    }
    
    func updateMessage(message: String, email: String, docId: String, completion:@escaping (Bool) -> ()){
        ref.collection("Messages").document(docId).updateData(["message":message, "email":email]) {
            (error) in
            if error != nil {
                print("error update message!\(String(describing: error))")
                completion(false)
                return
            }
            print("good-update message!")
            completion(true)
        }
    }
}
