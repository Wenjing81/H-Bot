//
//  UpdateView.swift
//  H-Bot
//
//  Created by Wenjing Zhang on 2021-03-04.
//

import SwiftUI

struct UpdateView : View {
    
    @EnvironmentObject var viewModel: MainViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @Binding var dismiss : Bool
    @Binding var docId :String
    @Binding var msg: String
    
    var body: some View{
        
        VStack(alignment: .leading, spacing: 25){
            
            Text("Message")
                .font(.title)
                .fontWeight(.bold)
            
            TextEditor(text: self.$msg)
                .font(.system(size: 14))
                .frame(height: 100)
                .background(RoundedRectangle(cornerRadius: 5)
                                //.strokeBorder(Color(red: 0, green: 255, blue: 255), lineWidth: 1))
                                .overlay(RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color(red: 0, green: 255, blue: 0), lineWidth: 1)))
                .disableAutocorrection(true)
                .autocapitalization(UITextAutocapitalizationType.none)
            //TextField("Message", text: self.$msg)
              // .textFieldStyle(RoundedBorderTextFieldStyle())
              //  .disableAutocorrection(true)
              //  .autocapitalization(UITextAutocapitalizationType.none)
            
            HStack(spacing: 15){
                
                Button(action: {
                    let email = authViewModel.email
                    //Updating...
                    self.viewModel.updateMessage(
                        message: self.msg,
                        email: email,
                        docId: self.docId
                    ){
                        (status) in
                        //do something if failed...
                    }
                    
                    self.dismiss.toggle()
                    
                }){
                    Text("Update")
                        .fontWeight(.bold)
                }
                
                Button(action: {
                    
                    withAnimation{
                        self.dismiss.toggle()
                    }
                }){
                    Text("Cancel")
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                }
            }
        }
        .padding()
        .background(Color.black)
        .cornerRadius(15)
        .padding(.horizontal,25)
        .background(
            Color.white.opacity(0.1)
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        )
    }
}

