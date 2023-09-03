//
//  MainView.swift
//  li
//
//  Created by 박승찬 on 2023/09/03.
//

import SwiftUI
import CoreLocation

struct MainView: View {
    @Binding var isFirstLaunching: Bool
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        ZStack{
            Color.blue
                .ignoresSafeArea()
            ScrollView{
                HStack{
                    Image(systemName: "location.fill")
                        
                    Text("\(locationManager.locationName)")
                        .font(.headline)
                    Spacer()
                    Image(systemName: "chevron.down")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(15)
                .padding()
                
                if let weather = locationManager.weather {
                    HStack{
                        Text("\(weather.currentWeather.temperature.formatted())")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.leading)

                    HStack{
                        Text("최고 \(weather.dailyForecast[0].highTemperature.formatted()) | 최저 \(weather.dailyForecast[0].lowTemperature.formatted())")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.leading)


                    // 10일후까지의 예보 뷰
                    SevenDayForecastView(dayWeatherList: weather.dailyForecast.forecast)

                }
                header
            }
//            .opacity(opacity)
            .onAppear {
                let appearance = UIScrollView.appearance()
                appearance.isPagingEnabled = true
                appearance.showsVerticalScrollIndicator = false
                appearance.showsHorizontalScrollIndicator = false

            }
        }
        .task(id: isFirstLaunching) {
            if !isFirstLaunching {
                locationManager.locationManager.requestAlwaysAuthorization()
            }
        }
        .task(id: locationManager.currentLocation) {
            do {
                if let location = locationManager.currentLocation {
                    
                    // MARK: - 현재위치 위도경도 이용해서 지역 명 가져오기
                    let geocoder = CLGeocoder()
                    let locale = Locale(identifier: "Ko-kr")
                    geocoder.reverseGeocodeLocation(location, preferredLocale: locale) { (placemarks, error) in
                        if let address: [CLPlacemark] = placemarks {
                            if let subLocality: String = address.last?.subLocality, let locality: String = address.last?.locality {
                                self.locationManager.locationName = "\(locality) \(subLocality)"
                            }
                        }
                        
                    }
                    
                    self.locationManager.weather = try await locationManager.weatherService.weather(for: location)
                }
            } catch {
                print(error)
            }
        }
    }
}

extension MainView{
    private var header: some View {
        Text("MainView")
    }
    
    private var tenDayForecastView: some View {
        VStack(alignment: .leading) {
            Text("10-day forecast")
                .font(.caption)
                .opacity(0.5)
            if let weather = locationManager.weather {
                List(weather.dailyForecast.forecast, id: \.date) { dailyWeather in
                    HStack {
                        Text(dailyWeather.date.formatAsAbbreviatedDay())
                            .frame(maxWidth: 50, alignment: .leading)
                        Image(systemName: "\(dailyWeather.symbolName).fill")
                            .foregroundColor(.yellow)
                        Text(dailyWeather.lowTemperature.formatted())
                            .frame(maxWidth: .infinity)
                        Text(dailyWeather.highTemperature.formatted())
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        
                    }.listRowBackground(Color.blue)
                    
                }.listStyle(.plain)

            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(isFirstLaunching: .constant(true))
    }
}
