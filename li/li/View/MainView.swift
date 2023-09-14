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
            ScrollView{
                VStack{
                    headerLocation
                    if let weather = locationManager.weather {
                        HStack{
                            Text("\(weather.currentWeather.temperature.formatted())")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .padding(.leading)
                        
                        HStack{
                            Text("최고 \(weather.dailyForecast[0].highTemperature.formatted()) | 최저 \(weather.dailyForecast[0].lowTemperature.formatted())")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .padding(.leading)
                        
                        Image("IntroView_MainImage")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 393, height: 352)
                            .padding(.bottom)
                        
                        HourlyForcastView(hourWeatherList: locationManager.hourlyWeatherData)
                            .frame(height: 120)
                        
                        slideUpText
                    } else {
                        HStack{
                            Text("- C")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .padding(.leading)
                        
                        HStack{
                            Text("최고 - C | 최저 - C")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .padding(.leading)
                        
                        Image("IntroView_MainImage")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 393, height: 352)
                            .padding(.bottom)
                        
//                        HourlyForcastView(hourWeatherList: [])
                        
                        slideUpText
                    }
                    
                }
                
                if let weather = locationManager.weather {
                    // 10일후까지의 예보 뷰
                    SevenDayForecastView(dayWeatherList: locationManager.dailyWeatherData)
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
        .onAppear {
            let appearance = UIScrollView.appearance()
            appearance.isPagingEnabled = true
//            appearance.showsVerticalScrollIndicator = false
//            appearance.showsHorizontalScrollIndicator = false
        }
    }
}

extension MainView{
    private var headerLocation: some View {
        HStack{
            Image(systemName: "location.fill")
                
            Text("\(locationManager.locationName)")
                .font(.headline)
            Spacer()
            Image(systemName: "chevron.down")
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(content: {
            RoundedRectangle(cornerRadius: 15)
                .strokeBorder(.black, lineWidth: 3)
                .frame(maxWidth: .infinity)

        })
        .cornerRadius(15)
        .padding()
    }
    
    private var slideUpText: some View {
        VStack{
            Text("위로 올려 일주일 날씨를 확인해요")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
                
            Image(systemName: "chevron.compact.up")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(isFirstLaunching: .constant(true))
    }
}
