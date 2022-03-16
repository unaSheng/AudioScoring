//
//  MainView.swift
//  AudioScoring
//
//  Created by MOMO on 2022/3/16.
//

import SwiftUI


struct MainView: View {
    
    @EnvironmentObject var user: User
    
    var body: some View {
        if user.isLoggedIn {
            LaunchView()
        } else {
            LoginView()
        }
    }
}


