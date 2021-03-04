//
//  SignInView.swift
//  H-BotWj2
//
//  Created by Wenjing Zhang on 2021-02-16.
//

import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    
    var body: some View{
        VStack{
            Text("H-Bot")
                .font(.system(size: 32, weight: .heavy))
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            
            Text("Effective system, Better service!")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color(.systemGray2))
            Spacer()
            VStack(spacing: 18){
                TextField("Email address", text: $email)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(red: 0, green: 255, blue: 0), lineWidth: 1))
                    .keyboardType(UIKeyboardType.emailAddress)
                    .disableAutocorrection(true)
                    .autocapitalization(UITextAutocapitalizationType.none)
                
                SecureField("Password", text: $password)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(red: 0, green: 255, blue: 255), lineWidth: 1))
            }
            .padding(.vertical, 64)
            
            Button(action: signIn){
                Text("Sign in")
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .background(LinearGradient(gradient: Gradient(colors: [Color(.systemGreen), Color(.systemBlue)]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                    .cornerRadius(5)
            }
            
            if (error != ""){
                Text(error)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.red)
                    .padding()
            }
            
            Spacer()
            
            NavigationLink(destination: SignUpView()) {
                HStack {
                    Text("New user.")
                        .font(.system(size: 20, weight: .light))
                        .foregroundColor(Color(.systemGreen))
                    
                    Text("Create an account.")
                        .font(.system(size: 20, weight: .light))
                        .foregroundColor(Color(.systemGreen))
                }
                .padding(.bottom)
            }
        }
        .padding(.horizontal, 32)
    }
    
    func signIn(){
        viewModel.signIn(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                viewModel.isLogged = true
                viewModel.saveEmail(email: email)
                self.email = ""
                self.password = ""
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
