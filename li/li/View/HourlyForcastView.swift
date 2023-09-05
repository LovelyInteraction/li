//
//  HourlyForcastView.swift
//  li
//
//  Created by 박승찬 on 2023/09/05.
//

import SwiftUI
import WeatherKit

struct HourlyForcastView: View {
    
    let hourWeatherList: [HourWeather]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(hourWeatherList, id: \.date) { hourWeatherItem in
                    Image(systemName: "\(hourWeatherItem.symbolName).fill")
                        .padding()
                }
            }.padding()
        }.scrollIndicators(.hidden)
    }
}

struct HourlyForcastView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyForcastView(hourWeatherList: [])
    }
}
