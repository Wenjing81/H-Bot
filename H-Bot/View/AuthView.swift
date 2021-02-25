//
//  AuthView.swift
//  H-BotWj2
//
//  Created by Wenjing Zhang on 2021-02-16.
//

import SwiftUI
// AuthView is a frame to navigate View to the first View - SignInView

struct AuthView: View {
    
    var body: some View {
        NavigationView {
            SignInView()
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()//.environmentObject(SessionStore())
    }
}
