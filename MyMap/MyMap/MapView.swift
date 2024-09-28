//
//  MapView.swift
//  MyMap
//
//  Created by Apple on 2024/09/26.
//

import SwiftUI
import MapKit

enum MapType {
    // 標準
    case standard
    // 衛生写真
    case statellite
    // 衛生写真 + 交通機関ラベル
    case hybrid
}

struct MapView: View {
    // 検索キーワード
    let searchKey: String
    // Map種類
    let mapType: MapType
    
    // キーワードから取得した緯度経度
    @State var targetCoordinate = CLLocationCoordinate2D()
    
    // 表示するMapの位置
    @State var cameraPosition : MapCameraPosition = .automatic
    
    // 表示するMapのスタイル
    var mapStyle: MapStyle {
        switch mapType {
        case .standard:
            return MapStyle.standard()
        case .statellite:
            return MapStyle.imagery()
        case .hybrid:
            return MapStyle.hybrid()
        }
    }
    
    var body: some View {
        Map(position: $cameraPosition) {
            // 第一引数: ピンのタイトル
            // 第二引数: ピンを指す緯度経度
            Marker(searchKey, coordinate: targetCoordinate)
        }
        // Mapスタイルを指定
        .mapStyle(mapStyle)
        // Map専用(?)のメソッド。第5引数まである
        .onChange(of: searchKey, initial: true) { oldValue, newValue in
            // 入力されたキーワードをデバッグエリアに表示
            print("検索キーワード: \(newValue)")
            
            // 地図の検索クエリの作成
            let request = MKLocalSearch.Request()
            // 検索クエリにキーワードの設定
            request.naturalLanguageQuery = newValue
            
            let search = MKLocalSearch(request: request)
            
            /*
             ①start()が実行される
             ②start()の実行が終了し、正常終了していれば変数responseに結果が格納される
             ③in内が実行される
             */
            search.start { response, error in
                
                /*
                「if let」では、代入が成功した場合にtrueが返る
                 複数の代入・判定を一気に実行したい場合はカンマで区切って記述する
                    →　全ての代入に成功した際、trueが返る
                */
                // MapItems()は配列であり、検索条件次第で複数の結果が格納される
                if let mapItems = response?.mapItems, //nilでない場合に代入
                   let mapItem = mapItems.first {
                    // placemarkの中に住所や地名,緯度などが格納されている
                    targetCoordinate = mapItem.placemark.coordinate
                    
                    print("緯度経度: \(targetCoordinate)")
                    
                    
                    cameraPosition = .region(MKCoordinateRegion(
                        center : targetCoordinate,
                        latitudinalMeters: 500.0,
                        longitudinalMeters: 500.0
                    ))
                }
            }
        }
    }
}

#Preview {
    MapView(searchKey: "東京駅", mapType: .standard)
}
