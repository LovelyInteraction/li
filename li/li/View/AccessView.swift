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
            Text("권한 어찌구\n주세요 ㅋㅋ")
                .font(.system(size: 32))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding()
            Text("날씨 정보 제공을 위해서\n위치와 사용자 추적 데이터가 필요해요")
                .font(.system(size: 16))
                .lineSpacing(8)
                .foregroundColor(.secondary)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                
        }
    }
    
    private var nextButton: some View {
        Button{
            print("AccessView: 다음버튼 클릭")
            isFirstLaunching.toggle()
        } label: {
            ZStack{
                Image("underLine")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 232)
                    .offset(y:10)
                Text("권한 요청하기")
                    .font(.system(size: 24))
                    .bold()
                    .padding()
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .background(content: {
                        RoundedRectangle(cornerRadius: 15)
                            .strokeBorder(.black, lineWidth: 3)
                            .frame(maxWidth: .infinity)

                    })
                    .cornerRadius(15)
            }
        }
        .padding()
    }
    
    private var mainImage: some View {
        ZStack{
            Image("AccessView_Img1")
        }
    }
}

struct AccessView_Previews: PreviewProvider {
    static var previews: some View {
        AccessView(isFirstLaunching: .constant(true))
    }
}
