//
//  SwiftUIView.swift
//  H-Bot
//
//  Created by Wenjing Zhang on 2021-02-25.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import Combine

class AuthViewModel: ObservableObject{
    
    @Published var isLogged: Bool = false
    var handle: AuthStateDidChangeListenerHandle? = nil
    var uid: String = ""
    var email: String? = nil
    
    // function to listen.
    func listen(){
        
    }
    //Create the new user using "createUser" method from Authentication of Firebase.
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback){
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    //Log in by using "signIn" method from Authentication of Firebase.
    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback){
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    //Log out by using "signOut" method from Authentication of Firebase.
    func signOut(){
        do {
            try Auth.auth().signOut()
            self.isLogged = false
        } catch {
            print("Error signing out")
        }
    }
    // Unbind listener by using removeStateDidChangeListener method from Authentication of Firebase. Beginning -> Ending, a whole process,perfect!
    
    func unbind(){
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    deinit{
        unbind()
    }
}
