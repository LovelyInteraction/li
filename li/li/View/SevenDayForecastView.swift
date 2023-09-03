//
//  SevenDayForecastView.swift
//  li
//
//  Created by 박승찬 on 2023/09/04.
//

import SwiftUI
import WeatherKit

struct SevenDayForecastView: View {
    
    let dayWeatherList: [DayWeather]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("10-day forecast")
                .font(.caption)
                .opacity(0.5)
            
            ForEach(dayWeatherList, id: \.date) { dailyWeather in
                HStack {
                    Text(dailyWeather.date.formatAsAbbreviatedDay())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Image(systemName: "\(dailyWeather.symbolName).fill")
                        .foregroundColor(.white)
                    Text("\(dailyWeather.condition.description)")
                        .foregroundColor(.white)
                        .frame(maxWidth: 70, alignment: .center)
                    Text(dailyWeather.highTemperature.formatted())
                        .frame(maxWidth: 40, alignment: .trailing)
                    Text(dailyWeather.lowTemperature.formatted())
                        .frame(maxWidth: 40, alignment: .trailing)
                        .opacity(0.5)
                    
                }
                .padding()
            }
        }
        .padding()
        .foregroundColor(.white)
    }
}

struct SevenDayForecastView_Previews: PreviewProvider {
    static var previews: some View {
        SevenDayForecastView(dayWeatherList: [])
    }
}
