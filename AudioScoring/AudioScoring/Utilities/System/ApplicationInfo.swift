//
//  ApplicationInfo.swift
//  AudioScoring
//
//  Created by MOMO on 2022/3/16.
//

import Foundation

struct ApplicationInfo {
    
    static var displayName: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? Bundle.main.bundleURL.deletingPathExtension().lastPathComponent
    }
    
    static var localizedDisplayName: String {
        return (Bundle.main.localizedInfoDictionary ?? [:])["CFBundleDisplayName"] as? String ?? displayName
    }
    
    static var build: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
    
    static var shortVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    //short version + build
    static var displayVersion: String {
        return "\(shortVersion ?? "0")(\(build ?? "N/A"))"
    }
    
}
