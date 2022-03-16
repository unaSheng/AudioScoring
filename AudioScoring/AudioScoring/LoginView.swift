//
//  LoginView.swift
//  AudioScoring
//
//  Created by MOMO on 2022/3/15.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var user: User
    
    var body: some View {
        VStack {
            Text("请输入用户名")
            
            Spacer()
                .frame(height: 20)
            
            TextField("", text: $user.username)
                .frame(width: 100, alignment: .center)
            
            Spacer()
                .frame(height: 20)
            
            Button("登录", action: {
                if user.username.trimmingCharacters(in: .whitespaces).count == 0 {
                    user.isLoggedIn = false
                } else {
                    user.isLoggedIn = true
                }
            })
        }.frame(alignment: .center)
    }
}
