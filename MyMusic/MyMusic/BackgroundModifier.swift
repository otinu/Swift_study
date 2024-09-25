//
//  BackgroundModifier.swift
//  MyMusic
//
//  Created by Apple on 2024/09/25.
//

import SwiftUI

// Imageを継承して、backgroundModifier()を追加
extension Image {
    func backgroundModifier() -> some View {
        self
            .resizable()
            .ignoresSafeArea()
            .scaledToFill()
    }
}
