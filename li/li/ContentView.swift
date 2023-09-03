//
//  ContentView.swift
//  li
//
//  Created by 박승찬 on 2023/08/31.
//

import SwiftUI

struct ContentView: View {
    // 사용자 안내 온보딩 페이지를 앱 설치 후 최초 실행할 때만 띄우도록 하는 변수.
    // @AppStorage에 저장되어 앱 종료 후에도 유지됨.
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
    
    var body: some View {
        MainView(isFirstLaunching: $isFirstLaunching)
            // 앱 최초 구동 시 전체화면으로 IntroView 띄우기
            .fullScreenCover(isPresented: $isFirstLaunching) {
                IntroView(isFirstLaunching: $isFirstLaunching)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
