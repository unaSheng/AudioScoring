//
//  AudioScoringApp.swift
//  AudioScoring
//
//  Created by MOMO on 2022/3/15.
//

import SwiftUI

@main
struct AudioScoringApp: App {

    @StateObject var user = User(username: "", isLoggedIn: false)

    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(user)
                .frame(minWidth: 600, minHeight: 500)
        }
    }
}
