//
//  ScoreModel.swift
//  AudioScoring
//
//  Created by MOMO on 2022/3/15.
//

import SwiftUI

class User: ObservableObject {
    @Published var username: String
    @Published var isLoggedIn: Bool
    
    init(username: String, isLoggedIn: Bool) {
        self.username = username
        self.isLoggedIn = isLoggedIn
    }
}

class AudioManager: ObservableObject {
    @Published var audios: [AudioModel] = []
    @Published var isAlertShowing = false
    @Published var hadOpenFile = false
    
    func loadFromLocal() {
        do {
            let url = try FilePicker.pickFile(isDirectory: true)
            let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            let sortedContents = contents.sorted(by: { a, b in
                if let pathA = (a.lastPathComponent.split(separator: "_").first as NSString?)?.intValue,
                   let pathB = (b.lastPathComponent.split(separator: "_").first as NSString?)?.intValue {
                    return pathA < pathB
                }
                return true
            })
            for content in sortedContents {
                let audio = try AudioModel(fileURL: content)
                audios.append(audio)
            }
            hadOpenFile = true
        } catch {
            isAlertShowing = true
        }
    }
}

class AudioModel: ObservableObject {
    var fileURL: URL
    @Published var audioPlayer: AudioPlayer
    @Published var questionnaire: AudioQuestionnaire
    @Published var checkedScore: Int = -1
    
    init(fileURL: URL) throws {
        self.fileURL = fileURL
        self.audioPlayer = AudioPlayer(audioFileURL: fileURL)
        let lastPathComponent = fileURL.lastPathComponent.lowercased()
        if let questionnaire = AudioQuestionnaireMap.first(where: { key, value in
            lastPathComponent.contains(key.localizedLowercase)
        })?.value {
            self.questionnaire = questionnaire
        } else {
            throw InstructionError("文件名：\(lastPathComponent) 不符合规范")
        }
    }
}

class AudioQuestionnaire: ObservableObject {
    var question: String
    var answer: String
    
    @Published var scores: [Int: String]
    
    init(question: String, answer: String, scores: [Int: String]) {
        self.question = question
        self.answer = answer
        self.scores = scores
    }
}

let AudioQuestionnaireMap: [String: AudioQuestionnaire] = [
    "NS_SIG": AudioQuestionnaire(question: "问：只关注人声，下列哪一项最能描述你刚才所听音频的感受？", answer: "答：我认为这条音频中的人声：", scores: [
        5: "十分自然，无失真",
        4: "自然，几乎不失真",
        3: "一般自然，有些失真",
        2: "不太自然，明显失真",
        1: "十分不自然，严重失真"
    ]),
    "NS_BAK": AudioQuestionnaire(question: "问：只关注噪声，下列哪一项最能描述你刚才所听音频的感受？", answer: "答：我认为这条音频中的噪声：", scores: [
        5: "不可察觉",
        4: "有些察觉",
        3: "有察觉但不烦扰",
        2: "明显察觉且烦扰",
        1: "非常明显且十分烦扰"
    ]),
    "NS_OVRL": AudioQuestionnaire(question: "问：整体来看，日常通话中，下列哪一项最符合你刚才所听音频的感受？", answer: "答：我认为这条音频中的人声：", scores: [
        5: "非常好",
        4: "好",
        3: "一般",
        2: "差",
        1: "很差"
    ]),
    "STNE_OVRL": AudioQuestionnaire(question: "问：整体来看，日常通话中，下列哪一项最符合你刚才所听音频的感受？", answer: "答：我认为这条音频中的人声：", scores: [
        5: "非常好",
        4: "好",
        3: "一般",
        2: "差",
        1: "很差"
    ]),
    "STFE_Echo": AudioQuestionnaire(question: "问：相比参考音频，你认为回声导致的音质退化程度有多大？", answer: "答：我认为回声对这条音频的影响：", scores: [
        5: "不可察觉",
        4: "有些察觉",
        3: "有察觉但不烦扰",
        2: "明显察觉且烦扰",
        1: "非常明显且十分烦扰"
    ]),
    "STFE_Other": AudioQuestionnaire(question: "问：相比参考音频，你认为其他因素(噪声)导致的音质退化程度有多大？", answer: "答：我认为其他因素(噪声)对这条音频的影响：", scores: [
        5: "不可察觉",
        4: "有些察觉",
        3: "有察觉但不烦扰",
        2: "明显察觉且烦扰",
        1: "非常明显且十分烦扰"
    ]),
    "DT_Echo": AudioQuestionnaire(question: "问：相比参考音频，你认为回声导致的音质退化程度有多大？", answer: "答：我认为回声对这条音频的影响：", scores: [
        5: "不可察觉",
        4: "有些察觉",
        3: "有察觉但不烦扰",
        2: "明显察觉且烦扰",
        1: "非常明显且十分烦扰"
    ]),
    "DT_Other": AudioQuestionnaire(question: "问：相比参考音频，你认为其他因素(噪声、人声失真)导致的音质退化程度有多大？", answer: "答：我认为其他因素(噪声、人声失真)对这条音频的影响：", scores: [
        5: "不可察觉",
        4: "有些察觉",
        3: "有察觉但不烦扰",
        2: "明显察觉且烦扰",
        1: "非常明显且十分烦扰"
    ]),
]
