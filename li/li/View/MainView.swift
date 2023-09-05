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
        GeometryReader { proxy in
            ZStack{
                Color.blue
                    .ignoresSafeArea()
                ScrollView{
                    VStack{
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
                            
                            Image("testImage")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 260, height: 350)
                                .padding(.bottom)
                            
                            HourlyForcastView(hourWeatherList: locationManager.hourlyWeatherData)
                        }
                    }
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    
                    if let weather = locationManager.weather {
                        // 10일후까지의 예보 뷰
                        SevenDayForecastView(dayWeatherList: weather.dailyForecast.forecast)
                            .frame(width: proxy.size.width, height: proxy.size.height)

                    }
                    
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
        .onAppear {
            let appearance = UIScrollView.appearance()
            appearance.isPagingEnabled = true
            appearance.showsVerticalScrollIndicator = false
            appearance.showsHorizontalScrollIndicator = false

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
