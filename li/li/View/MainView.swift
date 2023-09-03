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
                
                header
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
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(isFirstLaunching: .constant(true))
    }
}
