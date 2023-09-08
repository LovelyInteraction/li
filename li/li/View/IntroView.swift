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
                mainImage
                startButton
            }
        }
    }
}

extension IntroView {
    private var header: some View {
        Text("어서와요~\n두두튀에요^^")
            .font(.system(size: 32))
            .fontWeight(.semibold)
            .multilineTextAlignment(.center)
            .padding()
    }
    
    private var startButton: some View {
        NavigationLink(destination: AccessView(isFirstLaunching: $isFirstLaunching)) {
            ZStack{
                Image("underLine")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 232)
                    .offset(y:10)
                Text("날씨 보러 ㄱㄱ")
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
            }
        }
        .padding(23)
    }
    private var mainImage: some View {
        ZStack{
            Image("IntroView_Img1")
            Image("IntroView_Img2")
                .offset(y:80)
        }.offset(y:150)
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView(isFirstLaunching: .constant(true))
    }
}
