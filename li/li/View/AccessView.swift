//
//  AccessView.swift
//  li
//
//  Created by 박승찬 on 2023/09/03.
//

import SwiftUI

struct AccessView: View {
//    @StateObject private var locationManager = LocationManager()
    @Binding var isFirstLaunching: Bool
    
    var body: some View {
        VStack{
            Spacer()
            header
            Spacer()
            Spacer()
            mainImage
            Spacer()
            Spacer()
            nextButton
        }.navigationBarBackButtonHidden()
    }
}

extension AccessView {
    private var header: some View {
        VStack{
            ZStack{
                Image("AccessView_LineKiwi")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250)
                    .offset(y:33)
                Text("당신이 있는 곳,\n올바른 날시를 위해")
                    .titleFont2()
                    .padding()
            }
            Text("날씨 정보 제공을 위해서\n위치와 사용자 추적 데이터가 필요해요")
                .subTextFont()
                .foregroundColor(Color("subGray"))
                
        }
    }
    
    private var nextButton: some View {
        Button{
            print("AccessView: 다음버튼 클릭")
            isFirstLaunching.toggle()
        } label: {
            Text("권한 요청하기")
                .titleFont3()
                .padding()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 70)
                .background(.black)
                .cornerRadius(15)
            
        }
        .padding()
    }
    
    private var mainImage: some View {
        Image("AccessView_Img1")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
            .padding(30)
        
    }
}

struct AccessView_Previews: PreviewProvider {
    static var previews: some View {
        AccessView(isFirstLaunching: .constant(true))
    }
}
