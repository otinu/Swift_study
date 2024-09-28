//
//  ContentView.swift
//  MyTimer
//
//  Created by Apple on 2024/09/28.
//

import SwiftUI

struct ContentView: View {
    @State var timerHandler: Timer?
    @State var count : Int = 0
    // アプリを再起動しても、データを半永続化して保持する
    // 取り出すのはUserDefault内から
    @AppStorage("timer_value") var timerValue = 10
    @State var showAlert = false
    
    var body: some View {
        
        // NavigationStack で「先頭の画面であること」を宣言
        NavigationStack {
            ZStack {
                Image(.backgroundTimer)
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                
                // spacingで各Viewの間隔指定
                VStack(spacing: 30.0) {
                    Text("残り\(timerValue - count)秒")
                        .font(.largeTitle)
                    
                    HStack {
                        Button {
                            startTimer()
                        } label: {
                            Text("スタート")
                                .font(.title)
                                .foregroundStyle(.white)
                                // ボタンの幅と高さ指定
                                .frame(width: 140, height: 140)
                                .background(Color.start)
                                .clipShape(Circle())
                        }
                        
                        Button {
                            if let timerHandler {
                                // もしタイマーが実行中(値が0ではない)だったら
                                if timerHandler.isValid == true {
                                    // タイマー停止
                                    timerHandler.invalidate()
                                }
                            }
                        } label: {
                            Text("ストップ")
                                .font(.title)
                                .foregroundStyle(.white)
                                // ボタンの幅と高さ指定
                                .frame(width: 140, height: 140)
                                .background(Color.stop)
                                .clipShape(Circle())
                        }
                    }
                }
            }
            // 画面が表示される際に実行
            .onAppear {
                count = 0
            }
            
            // ツールバーを配置
            .toolbar {
                // ボタンをplacementの指定位置に配置
                ToolbarItem(placement: .topBarTrailing) {
                    // 画面遷移の指定
                    NavigationLink {
                        SettingView()
                    } label: {
                        Text("秒数設定")
                    }
                }
            }
            .alert("終了", isPresented: $showAlert) {
                Button("OK") {
                    print("OKタップ")
                }
            } message: {
                    Text("タイマー終了時間です")
            }
        }
    }
    
    func countDownTimer() {
        count += 1
        
        if timerValue - count <= 0 {
            // タイマー停止
            timerHandler?.invalidate()
            
            showAlert = true
        }
    }
    
    func startTimer() {
        if let timerHandler {
            // もしタイマーが実行中（値が入っている）だったら、スタートしない
            if timerHandler.isValid == true {
                return
            }
        }
        
        if timerValue - count <= 0 {
            count = 0
        }
        
        // タイマースタート
        // 「_」は第三引数の省略を意味
        timerHandler = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            // 1秒ごとにcountDownTimer()が呼び出される
            countDownTimer()
        }
    }
    
}

#Preview {
    ContentView()
}
