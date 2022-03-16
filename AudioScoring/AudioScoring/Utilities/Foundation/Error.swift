//
//  Error.swift
//  AudioScoring
//
//  Created by MOMO on 2022/3/16.
//

import Foundation

struct InstructionError: LocalizedError {
    private let instruction: String
    var errorDescription: String? { instruction }
    init(_ instruction: String) {
        self.instruction = instruction
    }

    static let cancel = InstructionError("InstructionError.Cancelled")

}
