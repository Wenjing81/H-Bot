//
//  SignUpView.swift
//  H-BotWj2
//
//  Created by Wenjing Zhang on 2021-02-16.
//

import SwiftUI

struct SignUpView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View{
        //Layout design for sign up View.
        VStack {
            Text("Create Account")
                .font(.system(size: 32, weight: .heavy))
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            
            Text("Sign up to get started")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color(.systemGray2))
            
            VStack(spacing: 18){
                TextField("Email address", text: $email)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(red: 0, green: 255, blue: 0), lineWidth: 1))
                    .disableAutocorrection(true)
                    .autocapitalization(UITextAutocapitalizationType.none)
                
                SecureField("Password", text: $password)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(red: 0, green: 255, blue: 255), lineWidth: 1))
                
            }.padding(.vertical, 64)
        }
        .padding()
        
        Button(action: signUp) {
            Text("Create Account")
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
                .frame(height:50)
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .bold))
                .background(LinearGradient(gradient: Gradient(colors: [Color(.systemGreen), Color(.systemBlue)]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                .cornerRadius(5)
        }
        .padding()
        
        if(error != ""){
            Text(error)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.red)
                .padding()
        }
        
        Spacer()
    }
    
    func signUp() {
        //When button clicked, session.signUp will be excuted, see this in SessionStore.swift.
        viewModel.signUp(email: email, password: password) { (result,error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                //When you succeed in registering, the user's data should have been uploaded to Authentication of Firebase and the area on the page should be empty.
                self.email = ""
                self.password = ""
                viewModel.isLogged = true
            }
        }
    }
}
