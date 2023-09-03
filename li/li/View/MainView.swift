//
//  MainView.swift
//  li
//
//  Created by 박승찬 on 2023/09/03.
//

import SwiftUI

struct MainView: View {
    @Binding var isFirstLaunching: Bool
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        header
            .task(id: isFirstLaunching) {
                if !isFirstLaunching {
                    locationManager.locationManager.requestAlwaysAuthorization()
                }
            }
    }
}

extension MainView{
    private var header: some View {
        Text("MainView")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(isFirstLaunching: .constant(true))
    }
}
