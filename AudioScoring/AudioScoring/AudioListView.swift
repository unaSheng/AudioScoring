//
//  ScoreListView.swift
//  AudioScoring
//
//  Created by MOMO on 2022/3/16.
//

import SwiftUI

struct AudioListView: View {
    
    @ObservedObject var audioManager: AudioManager

    @State private var selection: Int? = nil
    
    var body: some View {
        VStack {
            Spacer().frame(height: 40)
            Text("请在安静环境下，佩戴耳机，音量调至舒适状态后进行评测")
                .font(.title)
                .foregroundColor(.red)
            Spacer().frame(height: 40)
            NavigationView {
                List (0..<audioManager.audios.count,selection: $selection ) { i in
                    NavigationLink(audioManager.audios[i].fileURL.lastPathComponent, destination: {
                        QuestionnaireView(audioModel: audioManager.audios[i])
                        
                    })
                }
            }
         
            HStack {
                Button("上一条", action: {
                    if let index = selection {
                        selection = index - 1 < 0 ? nil : index - 1
                    }
                })
                Button("下一条", action: {
                    if let index = selection {
                        selection = index + 1
                    } else {
                        selection = 0
                    }
                })
            }
        }
    }
    
}
