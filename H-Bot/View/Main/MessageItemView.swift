//
//  MessageItemView.swift
//  H-Bot
//
//  Created by Wenjing Zhang on 2021-03-04.
//

import SwiftUI

struct MessageItemView: View {
    
    var displayMessage : Message
    //@EnvironmentObject var viewModel : MainViewModel
    @Binding var currentMsg : String
    @Binding var docId : String
    @Binding var updateMsg : Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack{
                Text(displayMessage.email)
                    .font(.title2)
                Divider()
                Text(displayMessage.title ?? "")
                    .font(.title2)
            }

            Text(displayMessage.msg!)
                .fixedSize(horizontal: false, vertical: true)
                //.lineLimit(nil)
                //.frame(width: 160)
                .font(.title3)
                .onTapGesture {
                    self.docId = displayMessage.id!
                    self.currentMsg = displayMessage.msg!
                    withAnimation {
                        self.updateMsg.toggle()
                    }
                }
            
            //Divider()
        }
    }
}
