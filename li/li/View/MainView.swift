//
//  MainView.swift
//  li
//
//  Created by 박승찬 on 2023/09/03.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        header
    }
}

extension MainView{
    private var header: some View {
        Text("MainView")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
