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
                .padding(.vertical,5)
                .padding(.horizontal)
                .background(Color("Kiwi"))
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
                                if Int(scrollOffset - 16) % 12 == 0 {
                                    HapticManager.instance.impact(style: .light)
                                }
                            }
                        )
                    
                    //시작과 마지막을 중앙으로 하기 위한 뷰들
                    ForEach(0...2, id: \.self) { _ in
                        Image(systemName: "\(hourWeatherList[0].symbolName).fill")
                            .foregroundColor(.white)
                            .padding(10)
                    }
                    ForEach(hourWeatherList, id: \.date) { hourWeatherItem in
                        VStack{
                            Image("MainView_Hourly_Line")
                                .offset(x: 22)
                            Spacer()
                            Image(systemName: "\(hourWeatherItem.symbolName).fill")
                                .padding(.horizontal,15)
                        }
                    }
                    //시작과 마지막을 중앙으로 하기 위한 뷰들
                    ForEach(0...2, id: \.self) { _ in
                        Image(systemName: "\(hourWeatherList[0].symbolName).fill")
                            .foregroundColor(.white)
                            .padding(12)
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
                    if num == 0{
                        time = "NOW"
                    }
                    HapticManager.instance.impact(style: .medium)
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
