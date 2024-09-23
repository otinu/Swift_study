import SwiftUI

struct ContentView: View {
    @State var outputText = "Hello World"
    
    var body: some View {
        VStack {
            Text(outputText)
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(Color.orange)
            Button("切り替えボタン") {
                outputText = "Nice👌"
            }
            // padding()が上にあるか下にあるかで、レイアウトに違いが出てくる
            // →レイアウトにつまづいたら、装飾メソッド(?)の呼び出し順も注意
            .padding(.all)
            .background(.purple)
            .foregroundColor(.white)
        }
    }
}

#Preview {
    ContentView()
}
