//
//  ContentView.swift
//  MyMusic
//
//  Created by Apple on 2024/09/24.
//

import SwiftUI

struct ContentView: View {
    
    let soundPlayer = SoundPlayer()
    
    var body: some View {
        // Z方向(奥行き)の指定
        ZStack {
            Image(.background)
                .backgroundModifier()
            
            HStack {
                Button {
                    soundPlayer.play(instrument: "cymbal")
                } label: {
                    Image(.cymbal)
                }
                Button {
                    soundPlayer.play(instrument: "guitar")
                } label: {
                    Image(.guitar)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
