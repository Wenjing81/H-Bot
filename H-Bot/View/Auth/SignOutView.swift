//
//  SignOutView.swift
//  H-Bot
//
//  Created by Wenjing Zhang on 2021-03-04.
//

import SwiftUI

struct SignOutView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack{
            Spacer()
            Text(viewModel.email)
                .font(.title2)
            Spacer()
            Button(action: viewModel.signOut) {
                Text("Sign Out")
                    .frame(maxWidth: .infinity)
                    .frame(height:50)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .background(LinearGradient(gradient: Gradient(colors: [Color(.systemGreen), Color(.systemBlue)]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                    .cornerRadius(5)
            }
            Spacer()
            Text("CopyRight Wenjing.\nVersion 1.6 202188")
                .font(.title2)
            Spacer()
        }
        .padding()
        .navigationBarTitle("Sign out?")
    }
}

struct SignOutView_Previews: PreviewProvider {
    static var previews: some View {
        SignOutView()
    }
}
