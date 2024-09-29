//
//  ImagePickerView.swift
//  MyCamera
//
//  Created by Apple on 2024/09/28.
//

// SwiftUIの中にUIKitも含まれている
import SwiftUI

// UIKitのUIViewControllerは
// UIViewControllerRepresentableを中継することで、SwiftUIと連携可能
struct ImagePickerView: UIViewControllerRepresentable {
    // @Bindingにより、@Stateで定義された変数を他のViewと共有して使用できる
    
    //UIViewController(写真撮影)が表示されているか管理
    @Binding var isShowSheet: Bool
    // 撮影した写真を格納する変数
    // 「?」をつけることで、nilを許容
    @Binding var captureImage: UIImage?
    
    class Coordinator: NSObject,
                       UINavigationControllerDelegate,
                       UIImagePickerControllerDelegate {
        
        // ImagePicerView型の定数を用意
        let parent: ImagePickerView
        
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        
        /*
         UIViewControllerを継承して、imagePickerControllerを実装した場合、撮影終了後の処理を実装できる
         　→imagePickerController()のような特定メソッドのことをdelegeteメソッドという
         　※delegete: 代理, 代表者
         
         delegateメソッドは、実装が必ず必要
         →抽象クラスの抽象メソッドと同じ。「継承クラスで実装してねメソッド」
         */
        
        // delegateメソッド
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            // 撮影した写真をcaptureImageに保存
            if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.captureImage = originalImage
            }
            
            self.parent.isShowSheet.toggle()
        }
        
        // delegateメソッド
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShowSheet.toggle()
        }
    }
    
    // Coorinatorを生成、SwiftUIによって自動的に呼び出し
    func makeCoordinator() -> Coordinator {
        // selfはImagePickerViewのこと
        Coordinator(self)
    }
    
    // Viewを生成する際に実行
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let myImagePickerController = UIImagePickerController()
        myImagePickerController.sourceType = .camera
        // delegateを利用するための通知先(どこにdelegateメソッドがあるか)を指定
        myImagePickerController.delegate = context.coordinator
        return myImagePickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: Context) {
        
    }
}
