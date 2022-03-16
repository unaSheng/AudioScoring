//
//  FileSaver.swift
//  AudioScoring
//
//  Created by MOMO on 2022/3/16.
//

import AppKit

struct FileSaver {
    static func saveFile(nameFieldStringValue: String) throws -> URL {
        let savePanel = NSSavePanel()
        savePanel.nameFieldStringValue = nameFieldStringValue
        let res = savePanel.runModal()
        switch res {
        case .OK:
            if let url = savePanel.url {
                return url
            } else {
                throw InstructionError("获取URL失败")
            }
        case .cancel:
            throw InstructionError.cancel
        default:
            throw InstructionError("未知错误")
        }
        
    }
    
}
