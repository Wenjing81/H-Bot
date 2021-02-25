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
                
                /*Spacer()
                 .fullScreenCover(isPresented: $shouldShowModal, content: {
                 Button(action: {shouldShowModal.toggle()}, label: {
                 Text("Fullscreen cover")
                 })
                 })*/
                
                switch selectedIndex {
                case 0:
                    NavigationView {
                    
                        MessageListView()
                    }
                    .navigationTitle("Message List")
                    
                    
                case 1:
                    /*ScrollView {
                     Text("TEST")
                     }*/
                    NavigationView{
                       // CreateNoteView ()
                    }.navigationTitle("Create new messages")
                    
                default:
                    NavigationView {
                        
                        //ProfileUpdateView()
                        
                    }
                    .navigationTitle("Profile update.")
                    
                }
                
            }
            
            //            Spacer()
            
            Divider()
                .padding(.bottom, 8)
            
            HStack {
                ForEach(0..<3) { num in
                    Button(action: {
                        
                        /* if num == 1 {
                         shouldShowModal.toggle()
                         return
                         }*/
                        
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
    var body: some View {
        VStack{
List{
                ForEach(self.messageViewModel.messages) { message in
                    
                    Text("helloText")
                    
                }
}
            HStack(spacing: 15){}
                .padding()
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
/*struct CreateNoteView: View {
    @State var title: String = ""
    @State var message: String = ""
    @ObservedObject var MainModel = MainViewModel()
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
            
            
            Spacer()
            Button(action: {
                //saving messages
                
                //auto id...
                let message = Message(msg: self.message, date: .init(date: Date()))
                
                self.MainViewModel.addMessage(message:self.message){ (status) in
                    //do something
                    //eg alerts if failed....
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
}*/

/*struct ProfileUpdateView: View {
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
            
        }
        //func updateProfile(){
        
        //}
        
    }
    
}*/



//.font(.system(size: 14))
//.frame(height: 100)
//.background(RoundedRectangle(cornerRadius: 5)
//.strokeBorder(Color(red: 0, green: 255, blue: 255), lineWidth: 1))


