//
//  SoundPlayer.swift
//  MyMusic
//
//  Created by Apple on 2024/09/24.
//

import UIKit
import AVFoundation

class SoundPlayer: NSObject {
    // 変数宣言
    let cymbalData = NSDataAsset(name: "cymbalSound")!.data
    let guitarData = NSDataAsset(name: "guitarSound")!.data
    // 定数宣言
    var player: AVAudioPlayer!
    
    func play(instrument: String) {
        do {
            if(instrument == "cymbal") {
                player = try AVAudioPlayer(data: cymbalData)
            } else if (instrument == "guitar") {
                player = try AVAudioPlayer(data: guitarData)
            }
            player.play()
        } catch {
            print("エラーが発生しました")
        }
    }
}
