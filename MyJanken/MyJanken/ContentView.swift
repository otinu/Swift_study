//
//  ContentView.swift
//  MyJanken
//
//  Created by Apple on 2024/09/23.
//

import SwiftUI

struct ContentView: View {
    
    // varで変数宣言
    // Intで型制約(記述なしも可能)
    @State var jankenNumber : Int = 0
    @State var 日本語の変数も使えるなんて : String = ""
    

    // ここは宣言しかできない
    @State var convartSample = 5
    // ToDo 型変換して再代入しようとするとエラーになる
    // convartSample = String(convartSample)
    

    // someのところが型宣言。someはJavaのvarのような抽象型。
    // 　→ここでTextやButtonなど【特定のUIパーツだけをリターンできるよう制限できそう】
    var body: some View {
        VStack {
            
            // 上部の領域いっぱいを確保
            Spacer()
               
            if jankenNumber == 0 {
                
            } else if jankenNumber == 1 {
                // 単一の式である場合、returnは省略できる。
                Image(.gu)
                // 画面に収まるよう調整
                    .resizable()
                // アスペクト比を維持しつつ、親のサイズに合わせる
                    .scaledToFit()
                
                Spacer()
                
                Text("グー")
                    .padding(.bottom)
            } else if jankenNumber == 2 {
                // 単一の式である場合、returnは省略できる。
                Image(.choki)
                // 画面に収まるよう調整
                    .resizable()
                // アスペクト比を維持しつつ、親のサイズに合わせる
                    .scaledToFit()
                
                Spacer()
                
                Text("チョキ")
                    .padding(.bottom)
            } else {
                // 単一の式である場合、returnは省略できる。
                Image(.pa)
                // 画面に収まるよう調整
                    .resizable()
                // アスペクト比を維持しつつ、親のサイズに合わせる
                    .scaledToFit()
                
                Spacer()
                
                Text("パー")
                    .padding(.bottom)
            }
            
            
            Button {
                var newJankenNumber = 0
                
                repeat {
                    newJankenNumber = Int.random(in: 1...3)
                } while jankenNumber == newJankenNumber
                
                jankenNumber = newJankenNumber
            } label: {
                Text("じゃんけんをする")
                    // こんな書き方はできない
                    // .frame(maxWidth: .infinity, height: 100)
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)
                    .font(.title)
                    .background(.pink)
                    .foregroundColor(.white)
            }
            
        }
    }
}

#Preview {
    ContentView()
}
