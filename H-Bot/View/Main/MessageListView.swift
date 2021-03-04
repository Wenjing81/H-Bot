//
//  MessageListView.swift
//  H-Bot
//
//  Created by Wenjing Zhang on 2021-03-04.
//

import SwiftUI

struct MessageListView: View {
    
    @EnvironmentObject var viewModel : MainViewModel
    @State var currentMsg = ""
    @State var docId = ""
    @State var updateMsg = false
    
    var body: some View {
        
        ZStack {
            VStack {
                List {
                    ForEach(self.viewModel.messages) { tempMsg in
                        MessageItemView(
                            displayMessage: tempMsg,
                            currentMsg: self.$currentMsg,
                            docId: self.$docId,
                            updateMsg: self.$updateMsg)
                            //.background(Color(.systemBlue))
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            viewModel.deleteMessage(docId: index)
                        }
                    }
                    .padding()
                }
                .padding()
            }
            //.padding()
            
            if self.updateMsg {
                UpdateView(
                    dismiss: self.$updateMsg,
                    docId: self.$docId,
                    msg: self.$currentMsg)
            }
        }
        .navigationBarTitle("Messages")
        //For deleting Data...
        .navigationBarItems(trailing: EditButton())
        .onAppear{
            //or you can call it in init....
            self.viewModel.getAllMessages()
        }
    }
}

