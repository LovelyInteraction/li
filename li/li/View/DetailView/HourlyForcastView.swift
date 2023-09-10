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
        ScrollViewReader { proxy in
            Text("\(time)")
                .font(.headline)
                .padding(.vertical,5)
                .padding(.horizontal)
                .background(Color("Kiwi"))
                .cornerRadius(30)
                .onTapGesture {
                    withAnimation {
                        proxy.scrollTo(0,anchor: .trailing)
                    }
                }
            //63
//            6.7
            ScrollView(.horizontal) {
                HStack{
                    ForEach(0...69, id: \.self){ index in
                        Image(linesOffset[index] > 168.5 && linesOffset[index] < 211.5 ? "MainView_Hourly_LineBlack" : "MainView_Hourly_LineGray")
                            .resizable()
//                            .scaledToFit()
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
                                        self.linesHeight[index] = 30
                                    } else if offset > 168.5 && offset < 211.5{
                                        self.linesHeight[index] = 20
                                    } else {
                                        self.linesHeight[index] = 15
                                    }
                                }
                            )
                    }
                }
                HStack {
//                    Color.clear
//                        .overlay(
//                            GeometryReader { geometry in
//                                Color.clear
//                                    .preference(key: OffsetPreferenceKey.self, value: geometry.frame(in: .named("scrollview")).origin.x)
//                            }
//                            .onPreferenceChange(OffsetPreferenceKey.self) { offset in
//                                self.scrollOffset = offset
//                                print("Offset: \(scrollOffset)")
//                                self.num = Int((scrollOffset - 16)/60)
//                                print("Offset: \(num)")
//                                if Int(scrollOffset - 16) % 12 == 0 {
//                                    HapticManager.instance.impact(style: .light)
//                                }
//                            }
//                        )
                    
//                    //시작과 마지막을 중앙으로 하기 위한 뷰들
//                    ForEach(0...2, id: \.self) { index in
//                        Image(systemName: "\(hourWeatherList[0].symbolName).fill")
//                            .foregroundColor(.white)
//                            .padding(10)
//                            .id(index)
//                    }
                    VStack{
                        Image(systemName: "\(hourWeatherList[0].symbolName).fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(symbolsOffset[0] > 148.5 && symbolsOffset[0] < 191.5 ? .black : .gray)
                            .frame(width: symbolsOffset[0] > 148.5 && symbolsOffset[0] < 191.5 ? 26 : 22)
                        //                                    .offset(x: geo.size.width)
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
                                        self.num = Int((scrollOffset - 16)/60)
                                        print("Offset: \(num)")
                                        if Int(scrollOffset - 16) % 12 == 0 {
                                            HapticManager.instance.impact(style: .light)
                                        }
                                    }
                            )
                        Spacer()
                    }
                    ForEach(1...23, id: \.self) { index in
                        VStack{
                            Image(systemName: "\(hourWeatherList[index].symbolName).fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(symbolsOffset[index] > 150 && symbolsOffset[index] < 190 ? .black : .gray)
                                .frame(width: symbolsOffset[index] > 150 && symbolsOffset[index] < 190 ? 26 : 22)
                            //                                    .offset(x: geo.size.width)
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
                        //                    //시작과 마지막을 중앙으로 하기 위한 뷰들
                        //                    ForEach(0...2, id: \.self) { _ in
                        //                        Image(systemName: "\(hourWeatherList[0].symbolName).fill")
                        //                            .foregroundColor(.white)
                        //                            .padding(12)
                        //                    }
                    }
                }
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
