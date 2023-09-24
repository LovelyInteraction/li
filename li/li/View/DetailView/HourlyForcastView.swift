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
    
    @State var symbolsOffset: [CGFloat] = Array(repeating: 0, count: 24)
    @State var linesOffset: [CGFloat] = Array(repeating: 0, count: 72)
    @State var linesHeight: [CGFloat] = Array(repeating: 15, count: 72)
    
    let hourWeatherList: [HourWeather]
    
    var body: some View {
        GeometryReader{ viewSize in
            ScrollViewReader { proxy in
                
//                LottieView(name: "Windy")
//                    .frame(width: viewSize.size.width, height: viewSize.size.width)
                LottieView(name: "\(lottieAboutWeather(hourWeatherList[num < 0 ? -1 * num : num]))")
                    .frame(width: viewSize.size.width, height: viewSize.size.width)
                Text("\(time)")
                    .timeFont()
                    .padding(.vertical,5)
                    .padding(.horizontal)
                    .background(Color("accentKiwi"))
                    .cornerRadius(30)
                    .onTapGesture {
                        withAnimation {
                            proxy.scrollTo(0,anchor: .trailing)
                        }
                    }
                
                GeometryReader{ geo in
                    ScrollView(.horizontal) {
                        HStack{
                            Rectangle()
                                .frame(width: geo.size.width/2, height: 40)
                                .foregroundColor(.white)
                                .padding(.horizontal,-12)
                            
                            VStack{
                                HStack{
                                    ForEach(0...69, id: \.self){ index in
                                        Image(linesOffset[index] > 168.5 && linesOffset[index] < 211.5 ? "MainView_Hourly_LineBlack" : "MainView_Hourly_LineGray")
                                            .resizable()
                                            .frame(width: 5,height: linesHeight[index])
                                            .padding(0.85)
                                            .offset(x: 1)
                                            .overlay(
                                                GeometryReader { geometry in
                                                    Color.clear
                                                        .preference(key: OffsetPreferenceKey.self, value: geometry.frame(in: .named("Line\(index)")).origin.x)
                                                }
                                                    .onPreferenceChange(OffsetPreferenceKey.self) { offset in
                                                        self.linesOffset[index] = offset
                                                        print("lineOffset\(index) : \(offset)")
                                                        if offset > 182 && offset < 198{
                                                            self.linesHeight[index] = 40
                                                        } else if offset > 168.5 && offset < 211.5{
                                                            self.linesHeight[index] = 27
                                                        } else {
                                                            self.linesHeight[index] = 20
                                                        }
                                                    }
                                            )
                                    }
                                }
                                .frame(height: 40)
                                
                                HStack {
                                    VStack{
                                        Image(systemName: "\(hourWeatherList[0].symbolName).fill")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(symbolsOffset[0] > 148.5 && symbolsOffset[0] < 191.5 ? .black : .gray)
                                            .frame(width: symbolsOffset[0] > 148.5 && symbolsOffset[0] < 191.5 ? 26 : 22)
                                            .offset(y: symbolsOffset[0] > 148.5 && symbolsOffset[0] < 191.5 ? 0 : -10)
                                            .padding(.horizontal,symbolsOffset[0] > 148.5 && symbolsOffset[0] < 191.5 ? 5 : 7)
                                            .overlay(
                                                GeometryReader { geometry in
                                                    Color.clear
                                                        .preference(key: OffsetPreferenceKey.self, value: geometry.frame(in: .named("symbol\(0)")).origin.x)
                                                }
                                                    .onPreferenceChange(OffsetPreferenceKey.self) { offset in
                                                        self.symbolsOffset[0] = offset
                                                        print("symbolOffset\(0) : \(offset)")
                                                    }
                                            )
                                            .overlay(
                                                GeometryReader { geometry in
                                                    Color.clear
                                                        .preference(key: OffsetPreferenceKey.self, value: geometry.frame(in: .named("scrollview")).origin.x)
                                                }
                                                    .onPreferenceChange(OffsetPreferenceKey.self) { offset in
                                                        self.scrollOffset = offset
                                                        print("Offset: \(scrollOffset)")
                                                        self.num = Int((scrollOffset - 180.5)/43.6667)
                                                        print("Offset: \(num)")
                                                        
                                                    }
                                            )
                                        Spacer()
                                    }
                                    ForEach(1...23, id: \.self) { index in
                                        VStack{
                                            Image(systemName: "\(hourWeatherList[index].symbolName).fill")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundColor(symbolsOffset[index] > 148.5 && symbolsOffset[index] < 191.5 ? .black : .gray)
                                                .frame(width: symbolsOffset[index] > 148.5 && symbolsOffset[index] < 191.5 ? 26 : 22)
                                                .offset(y: symbolsOffset[index] > 148.5 && symbolsOffset[index] < 191.5 ? 0 : -10)
                                                .padding(.horizontal,7)
                                                .overlay(
                                                    GeometryReader { geometry in
                                                        Color.clear
                                                            .preference(key: OffsetPreferenceKey.self, value: geometry.frame(in: .named("symbol\(index)")).origin.x)
                                                    }
                                                        .onPreferenceChange(OffsetPreferenceKey.self) { offset in
                                                            self.symbolsOffset[index] = offset
                                                            print("symbolOffset\(index) : \(offset)")
                                                        }
                                                )
                                            Spacer()
                                        }
                                    }
                                }
                            }
                            Rectangle()
                                .frame(width: geo.size.width/2, height: 40)
                                .foregroundColor(.white)
                                .padding(.horizontal,-12)
                        }
                    }
                    .scrollIndicators(.hidden)
                    .coordinateSpace(name: "scrollview")
                    .task(id: num) {
                        let calendar = Calendar.current
                        let components = calendar.dateComponents([.hour, .minute, .second], from: hourWeatherList[0].date)
                        if let now = components.hour {
                            time = String((now - num) % 24) + ":00"
                            if num == 0{
                                time = "NOW"
                            }
                        }
                        print("condition: \(lottieAboutWeather(hourWeatherList[num < 0 ? -1 * num : num]))")
                    }
                    .task(id: linesHeight) {
                        HapticManager.instance.impact(style: .light)
                    }
                }
            }
        }
    }
}

//struct HourlyForcastView_Previews: PreviewProvider {
//    static var previews: some View {
//        HourlyForcastView(hourWeatherList: [])
//    }
//}

struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension HourlyForcastView {
    func lottieAboutWeather(_ hourWeather: HourWeather) -> String {
        switch hourWeather.condition{
        case .clear, .hot, .frigid:
            return "맑음"
        case .mostlyClear, .mostlyCloudy, .partlyCloudy:
            return "Windy"
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
            return "Windy"
        @unknown default:
            return "알 수 없음"
        }
    }
}
