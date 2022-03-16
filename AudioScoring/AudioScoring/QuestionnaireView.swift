//
//  ScoreView.swift
//  AudioScoring
//
//  Created by MOMO on 2022/3/15.
//

import SwiftUI
import AVFoundation

struct QuestionnaireView: View {
    
    @ObservedObject var audioModel: AudioModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                    .frame(width: 20)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("请听下面的音频片段：")
                    HStack {
                        playButton()
                        Slider(value: $audioModel.audioPlayer.progress, in: 0.0...1.0) { _ in
                            if let duration = audioModel.audioPlayer.duration {
                                audioModel.audioPlayer.seek(time: Double(audioModel.audioPlayer.progress) * duration.seconds)
                            }
                        }
                    }
                    Text(audioModel.questionnaire.question)
                        .font(.title2)
                    
                    HStack {
                        Text(audioModel.questionnaire.answer)
                            .font(.title2)
                        Spacer()
                        Text("分数")
                            .font(.title2)
                    }
                    
                    Divider()
                    
                    ForEach(audioModel.questionnaire.scores.keys.map({ $0 }).sorted(by: { $1 < $0}), id: \.self, content: { score in
                        HStack {
                            Button("", action: {
                                
                            })
                            
                            Text(audioModel.questionnaire.scores[score]!)
                            Spacer()
                            Text("\(score)")
                        }
                    })
                }
                .frame(minWidth: 400)
                
                Spacer()
                    .frame(width: 20)
            }
            Spacer()
        }
    }
    
    private func playButton() -> some View {
        Button(action: {
            if audioModel.audioPlayer.isPlaying {
                audioModel.audioPlayer.pause()
            } else {
                audioModel.audioPlayer.play()
            }
        }, label: {
            Image(systemName: audioModel.audioPlayer.isPlaying == true ? "pause.fill" : "play.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 18, height: 18)
        })
            .buttonStyle(PlainButtonStyle())
    }
}
