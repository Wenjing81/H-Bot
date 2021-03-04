//
//  MainView.swift
//  H-BotWj2
//
//  Created by Wenjing Zhang on 2021-02-17.
//

import SwiftUI

struct MainView: View {
    
    @State var selectedIndex = 0
    @State var shouldShowModal = false
    
    init() {
        UITabBar.appearance().barTintColor = .systemBackground
        UINavigationBar.appearance().barTintColor = .systemBackground
    }
    
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
                        CreateNoteView(selectedIndex: self.$selectedIndex)
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
