//
//  AudioPlayer.swift
//  AudioScoring
//
//  Created by MOMO on 2022/3/16.
//

import Foundation
import AVFoundation

class AudioPlayer: ObservableObject {
    
    @Published private(set) var isPlaying = false
    
    @Published var progress: Float = 0
    
    private(set) var duration: CMTime?
    private var player: AVPlayer
    private var timeObserverToken: Any? = nil
    private var statusObservation: NSKeyValueObservation?
    
    init(audioFileURL: URL) {
        self.player = AVPlayer(url: audioFileURL)
        statusObservation = player.currentItem?.observe(\.status, options: [], changeHandler: { [weak self] playerItem, change in
            if playerItem.status == .readyToPlay {
                self?.duration = playerItem.duration
            }
        })
    }
    
    func play() {
        guard timeObserverToken == nil, let duration = self.duration else { return }
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: CMTime(value: 1, timescale: 30), queue: .main) { [weak self] time in
            guard let strongSelf = self else {
                return
            }
            strongSelf.progress = Float(time.seconds / duration.seconds)
            print(strongSelf.progress)
        }
        player.play()
        isPlaying = true
    }
    
    func pause() {
        if let token = timeObserverToken {
            player.removeTimeObserver(token)
            timeObserverToken = nil
        }
        player.pause()
        isPlaying = false
    }
    
    func seek(time: TimeInterval) {
        player.seek(to: CMTime(seconds: time, preferredTimescale: 48_000))
    }
}
