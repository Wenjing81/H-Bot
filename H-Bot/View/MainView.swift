//
//  MainView.swift
//  H-BotWj2
//
//  Created by Wenjing Zhang on 2021-02-17.
//

import SwiftUI

struct MainView: View {
    
    init() {
        UITabBar.appearance().barTintColor = .systemBackground
        UINavigationBar.appearance().barTintColor = .systemBackground
    }
    
    @State var selectedIndex = 0
    @State var shouldShowModal = false
    
    
    let tabBarImageNames = ["list.bullet.rectangle", "plus.app.fill", "person.crop.circle"]
    
    var body: some View {
        VStack(spacing: 0) {
            
            ZStack {
                
                //Layout of main page view. 3 different buttons to list messages, create new message or update the user's profile.
                switch selectedIndex {
                case 0:
                    NavigationView {
                        //View to list messages.
                        MessageListView()
                    }
                    .navigationTitle("Message List")
                    
                    
                case 1:
                    NavigationView{
                        //View to create a new message.
                        CreateNoteView ()
                    }.navigationTitle("Create new messages")
                    
                default:
                    NavigationView {
                        
                        SignOutView()
                        
                    }
                    .navigationTitle("Sign out")
                }
                
            }
            
            //            Spacer()
            
            Divider()
                .padding(.bottom, 8)
            
            HStack {
                ForEach(0..<3) { num in
                    Button(action: {
                        selectedIndex = num
                    }, label: {
                        Spacer()
                        
                        if num == 1 {
                            Image(systemName: tabBarImageNames[num])
                                .font(.system(size: 44, weight: .bold))
                                .foregroundColor(.red)
                        } else {
                            Image(systemName: tabBarImageNames[num])
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(selectedIndex == num ? Color(.black) : .init(white: 0.8))
                        }
                        Spacer()
                    })
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct MessageListView: View {
    @State var message = ""
    @ObservedObject var messageViewModel = MainViewModel()
    @State var docId = ""
    @State var updateMsg = false
    var body: some View {
        ZStack{
            VStack{
                List{
                    ForEach(self.messageViewModel.messages) { message in
                        //print("\(self.messageViewModel.messages.count)")
                        //Text("\(message.date!)")
                        Text(message.msg!)
                            .onTapGesture{
                                self.docId = message.id!
                                self.message = message.msg!
                                withAnimation{
                                    self.updateMsg.toggle()
                                }
                            }
                    }
                    .onDelete{(indexSet) in
                        for index in indexSet{
                            self.messageViewModel.deleteMessage(docId: index)
                        }
                    }
                }
                .padding()
            }
            
            if self.updateMsg{
                UpdateView(messageViewModel: self.messageViewModel,
                           dismiss: self.$updateMsg,
                           docId: self.$docId,
                           msg: self.$message)
            }
        }
        .navigationBarTitle("Messages")
        //For deleting Data...
        .navigationBarItems(trailing: EditButton())
        .onAppear{
            //or you can call it in init....
            self.messageViewModel.getAllMessages()
        }
    }
}
struct MessageListView_Previews: PreviewProvider {
    static var previews: some View {
        MessageListView().environmentObject(MainViewModel())
    }
}

struct UpdateView : View {
    @ObservedObject var messageViewModel: MainViewModel
    @Binding var dismiss : Bool
    @Binding var docId :String
    @Binding var msg: String
    
    var body: some View{
        
        VStack(alignment: .leading, spacing: 25){
            
            Text("Message")
                .font(.title)
                .fontWeight(.bold)
            
            TextField("Message", text: self.$msg)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
                .autocapitalization(UITextAutocapitalizationType.none)
            
            HStack(spacing: 15){
                
                Button(action: {
                    
                    //Updating...
                    self.messageViewModel.updateMessage(message: self.msg, docId: self.docId){
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
struct CreateNoteView: View {
    
    @State var message = ""
    @State var title = ""
    @ObservedObject var messageViewModel = MainViewModel()
    @State var docId = ""
    
    var body: some View {
        
        VStack{
            HStack{
                Text("Title")
                TextField("Title",  text: self.$title)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5)
                                    .strokeBorder(Color(red: 0, green: 255, blue: 0), lineWidth: 1))
            }
            Spacer()
            HStack{
                Text("Message")
                TextEditor(text: self.$message)
                    .font(.system(size: 14))
                    .frame(height: 100)
                    .background(RoundedRectangle(cornerRadius: 5)
                                    //.strokeBorder(Color(red: 0, green: 255, blue: 255), lineWidth: 1))
                                    .overlay(RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color(red: 0, green: 255, blue: 255), lineWidth: 1)))
                    .padding()
            }
            .navigationBarTitle("Any problems?")
            
            
            Spacer()
            Button(action:{
                
                //saving message...
                //auto id ...
                
                let message = Message(date: .init(date: Date()), msg: self.message)
                
                self.messageViewModel.addMessage(message: message){(status) in
                    
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
        
        Spacer()
    }
    struct CreateNoteView_Previews: PreviewProvider {
        static var previews: some View {
            CreateNoteView().environmentObject(MainViewModel())
        }
    }
    
    
}

struct SignOutView: View {
    @EnvironmentObject var store: AuthViewModel
    var body: some View {
        HStack{
            Button(action: store.signOut) {
                Text("Sign Out")
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
                    .frame(height:50)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .background(LinearGradient(gradient: Gradient(colors: [Color(.systemGreen), Color(.systemBlue)]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                    .cornerRadius(5)
            }
        }.navigationBarTitle("Sign out?")
    }
}
