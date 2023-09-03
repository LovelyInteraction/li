//
//  LocationManager.swift
//  li
//
//  Created by 박승찬 on 2023/09/03.
//

import Foundation
import CoreLocation
import WeatherKit

// MARK: - 현재위치 설정하기
class LocationManager: NSObject, ObservableObject {
    
    let weatherService = WeatherService.shared
    
    @Published var weather: Weather?
    @Published var locationName: String = ""
    
    @Published var currentLocation: CLLocation?
    let locationManager = CLLocationManager()
    
    // 시간별 데이터를 가져올 때 현재 시간보다 24시간 뒤까지만 가져오도록 하기 위한 코드
    var hourlyWeatherData: [HourWeather] {
        if let weather {
            return Array(weather.hourlyForecast.filter{ hourlyWeather in
                return hourlyWeather.date.timeIntervalSince(Date()) >= 0
            }.prefix(24))
        } else {
            return []
        }
    }
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
//        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
}

// 위치 정보를 가장최근 위치로 하여 현재위치 조정하기
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last, currentLocation == nil else {return} // 현재위치가 nil이 아닐경우 return해주고 nil일 경우 현재 위치 조정해주기 위한 guard문
        
        DispatchQueue.main.async {
            self.currentLocation = location
        }
    }
}

// MARK: - 날짜 표시 방법 변경(ex. Sunday -> Sun)
extension Date {
    func formatAsAbbreviatedDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: self)
    }
    
    func formatAsAbbreviatedTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "ha"
        return formatter.string(from: self)
    }
}
