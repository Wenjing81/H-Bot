//
//  CreateNoteView.swift
//  H-Bot
//
//  Created by Wenjing Zhang on 2021-03-04.
//

import SwiftUI

struct CreateNoteView: View {
    
    @EnvironmentObject var viewModel: MainViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @Binding var selectedIndex : Int
    @State var message = ""
    @State var title = ""
    @State var docId = ""
    
    var body: some View {
        
        VStack {
            Spacer()
            HStack {
                Text("Category")
                TextField("Category",  text: self.$title)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5)
                                    .strokeBorder(Color(red: 0, green: 255, blue: 0), lineWidth: 1))
                    .disableAutocorrection(true)
                    .autocapitalization(UITextAutocapitalizationType.none)
            }
            Spacer()
            HStack {
                Text("Message")
                TextEditor(text: self.$message)
                    .font(.system(size: 14))
                    .frame(height: 100)
                    .background(RoundedRectangle(cornerRadius: 5)
                                    //.strokeBorder(Color(red: 0, green: 255, blue: 255), lineWidth: 1))
                                    .overlay(RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color(red: 0, green: 255, blue: 0), lineWidth: 1)))
                    .disableAutocorrection(true)
                    .autocapitalization(UITextAutocapitalizationType.none)
            }
            
            Spacer()
            Button(action:{
                
                //saving message...
                //auto id ...
                
                let message = Message(
                    date: .init(date: Date()),
                    title: self.title,
                    msg: self.message,
                    email: authViewModel.email)
                
                self.viewModel.addMessage(message: message){ (status) in
                    self.selectedIndex = 0
                    //do something
                    //eg alerts if failed
                }
                
                self.message = ""
            }){
                Text("Send Message")
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
                    .frame(height:50)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .background(LinearGradient(gradient: Gradient(colors: [Color(.systemGreen), Color(.systemBlue)]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                    .cornerRadius(5)
            }
        }
        .padding()
        .navigationTitle("Any problems?")
        
        Spacer()
    }
}

