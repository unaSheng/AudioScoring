//
//  LunchView.swift
//  AudioScoring
//
//  Created by MOMO on 2022/3/16.
//

import SwiftUI

struct LaunchView: View {
    
    @StateObject private var audioManager = AudioManager()
    
    var body: some View {
        if audioManager.hadOpenFile {
            AudioListView(audioManager: audioManager)
        } else {
            VStack {
                logoView()
                Spacer().frame(height: 40)
                actionView()
            }
            .navigationTitle(" ")
            .frame(minWidth: 1000, minHeight: 600)
            .alert(isPresented: $audioManager.isAlertShowing) {
                Alert(title: Text("出错了"),
                      message: Text(""),
                      dismissButton: .default(Text("知道了")))
            }
        }
    }
    
    private func logoView() -> some View {
        VStack {
            Image(systemName: "music.quarternote.3")
                .font(.system(size: 72))
            
            Text(ApplicationInfo.displayVersion)
                .font(.system(size: 12))
        }
    }
    
    private func actionView() -> some View {
        VStack(alignment: .leading, spacing: 24) {
            Button(action: {
                audioManager.loadFromLocal()
            }, label: {
                Image(systemName: "folder.badge.plus").frame(width: 22)
                Text("选择本地文件")
            })
            
        }
        .font(.title3)
        .buttonStyle(PlainButtonStyle())
        .foregroundColor(.accentColor)
    }
}
