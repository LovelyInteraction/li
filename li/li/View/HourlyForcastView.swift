//
//  HourlyForcastView.swift
//  li
//
//  Created by 박승찬 on 2023/09/05.
//

import SwiftUI
import WeatherKit

struct HourlyForcastView: View {
    
    @State private var scrollOffset: CGFloat = 0
    @State private var num: Int = 0
    @State var time: String = "00:00"
    
    let hourWeatherList: [HourWeather]
    
    var body: some View {
        VStack{
            Text("\(time)")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.vertical,5)
                .padding(.horizontal)
                .background(Color.black)
                .cornerRadius(30)
            //63
            ScrollView(.horizontal) {
                HStack {
                    Color.clear
                        .overlay(
                            GeometryReader { geometry in
                                Color.clear
                                    .preference(key: OffsetPreferenceKey.self, value: geometry.frame(in: .named("scrollview")).origin.x)
                            }
                            .onPreferenceChange(OffsetPreferenceKey.self) { offset in
                                self.scrollOffset = offset
                                print("Offset: \(scrollOffset)")
                                self.num = Int((scrollOffset - 16)/60)
                                print("Offset: \(num)")
                            }
                        )
                    ForEach(hourWeatherList, id: \.date) { hourWeatherItem in
                        Image(systemName: "\(hourWeatherItem.symbolName).fill")
                            .padding(15)
                    }
                }.padding()
            }
            .scrollIndicators(.hidden)
            //wwdc23 발표 내용
            //.scrollTargetBehavior(.paging)
            .coordinateSpace(name: "scrollview")
            .task(id: num) {
                let calendar = Calendar.current
                let components = calendar.dateComponents([.hour, .minute, .second], from: hourWeatherList[0].date)
                if let now = components.hour {
                    time = String(now - num) + ":00"
                }
            }
        }
        
    }
}

struct HourlyForcastView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyForcastView(hourWeatherList: [])
    }
}

struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
