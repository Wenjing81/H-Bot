//
//  ContentView.swift
//  H-BotWj2
//
//  Created by Wenjing Zhang on 2021-02-16.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    func getUser(){
        viewModel.listen()
    }
    
    var body: some View {
        Group {
            if(viewModel.isLogged){
                MainView()
            }else {
                AuthView()
            }
        }.onAppear(perform: getUser)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
