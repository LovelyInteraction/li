//
//  IntroView.swift
//  li
//
//  Created by 박승찬 on 2023/09/03.
//

import SwiftUI

struct IntroView: View {
    @Binding var isFirstLaunching: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                header
                Spacer()
                Spacer()
                mainImage
                Spacer()
                Spacer()
                startButton
            }
        }
    }
}

extension IntroView {
    private var header: some View {
        ZStack{
            Image("AccessView_LineKiwi")
                .resizable()
                .scaledToFit()
                .frame(width: 280)
                .offset(y:33)
            Text("반가워요\n날씨를 확인해볼까요?")
                .font(.system(size: 32))
                .fontWeight(.bold)
                .lineSpacing(7)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
    
    private var startButton: some View {
        NavigationLink(destination: AccessView(isFirstLaunching: $isFirstLaunching)) {
                Text("시작하기")
                    .font(.system(size: 24))
                    .bold()
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
        Image("IntroView_MainImage")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
            .padding(-40)
            
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView(isFirstLaunching: .constant(true))
    }
}
