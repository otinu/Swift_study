//
//  ContentView.swift
//  MyCamera
//
//  Created by Apple on 2024/09/28.
//

import SwiftUI

struct ContentView: View {
    // 撮影した写真を保持する状態変数
    @State var captureImage: UIImage? = nil
    // 撮影画面（sheet）の開閉状態を管理
    @State var isShowSheet = false
    
    var body: some View {
        VStack {
            Spacer()
            
            if let captureImage {
                Image(uiImage: captureImage)
                    .resizable()
                    .scaledToFit()
            }
            
            Spacer()
            
            Button {
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    print("カメラは利用できます")
                    
                    isShowSheet.toggle()
                } else {
                    print("カメラは利用できません")
                }
            } label: {
                Text("カメラを起動する")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .multilineTextAlignment(.center)
                    .background(.blue)
                    .foregroundColor(.white)
            }
            .padding()
            .sheet(isPresented: $isShowSheet) {
                ImagePickerView(isShowSheet: $isShowSheet, captureImage: $captureImage)
            }
        }
    }
}

#Preview {
    ContentView()
}
