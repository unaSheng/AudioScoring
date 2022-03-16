//
//  FilePicker.swift
//  AudioScoring
//
//  Created by MOMO on 2022/3/16.
//

import AppKit

struct FilePicker {
    static func pickFile(isDirectory: Bool) throws -> URL {
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = true
        openPanel.canChooseFiles = !isDirectory
        openPanel.canChooseDirectories = isDirectory
        let res = openPanel.runModal()
        switch res {
        case .OK:
            if let url = openPanel.url {
                return url
            } else {
                throw InstructionError("获取URL失败")
            }
        case .cancel:
            throw InstructionError.cancel
        default:
            assertionFailure()
            throw InstructionError("未知错误")
        }
    }
}
