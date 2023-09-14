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
            HStack{
                Image(systemName: "calendar")
                Text("일주일 날씨")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
            }
            Rectangle()
                .fill(.black)
                .frame(height: 2)
                .frame(maxWidth: .infinity)
            
            ForEach(dayWeatherList, id: \.date) { dailyWeather in

                HStack {
                    Text(dailyWeather.date.formatAsAbbreviatedDay())
                        .font(.system(size: 20))
                        .bold()
                        .frame(maxWidth: 65, alignment: .leading)
                    
                    Image(systemName: dailyWeather.condition == .windy ? "\(dailyWeather.symbolName)" : "\(dailyWeather.symbolName).fill")
                    
                    Text("\(weatherConditionAsKorean(dailyWeather))")
                        .font(.system(size: 20))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("\(Int(dailyWeather.highTemperature.value))°")
                        .font(.system(size: 20))
                        .bold()
                        .frame(maxWidth: 53, alignment: .leading)
                    
                    Text("\(Int(dailyWeather.lowTemperature.value))°")
                        .font(.system(size: 20))
                        .bold()
                        .frame(maxWidth: 52, alignment: .trailing)
                        .opacity(0.5)
                    
                }
                .padding(.vertical, 20)
                
                Rectangle()
                    .fill(.black)
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(23)
//        .foregroundColor(.white)
    }
}

struct SevenDayForecastView_Previews: PreviewProvider {
    static var previews: some View {
        SevenDayForecastView(dayWeatherList: [])
    }
}

extension SevenDayForecastView {
    func weatherConditionAsKorean(_ dayWeather: DayWeather) -> String {
        switch dayWeather.condition{
        case .clear, .hot, .frigid:
            return "맑음"
        case .mostlyClear, .mostlyCloudy, .partlyCloudy:
            return "구름"
        case .cloudy:
            return "흐림"
        case .drizzle, .heavyRain, .rain, .sunShowers :
            return "비"
        case .hail, .flurries, .sleet, .snow, .sunFlurries, .wintryMix, .blizzard, .blowingSnow, .freezingDrizzle, .freezingRain, .heavySnow:
            return "눈"
        case .isolatedThunderstorms, .scatteredThunderstorms, .strongStorms, .thunderstorms:
            return "천둥번개"
        case .foggy, .haze, .smoky:
            return "안개"
        case .breezy, .windy, .hurricane, .tropicalStorm, .blowingDust:
            return "바람"
        @unknown default:
            return "알 수 없음"
        }
    }
}
