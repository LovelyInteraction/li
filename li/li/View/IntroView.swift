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
                Spacer()
                startButton
            }
        }
    }
}

extension IntroView {
    private var header: some View {
        Text("환영해요\n어찌구\n날씨앱 어찌구에요.")
            .font(.system(size: 32))
            .fontWeight(.semibold)
            .multilineTextAlignment(.center)
            .padding()
    }
    
    private var startButton: some View {
        NavigationLink(destination: AccessView(isFirstLaunching: $isFirstLaunching)) {
            Text("시작하기")
                .font(.headline)
                .padding()
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .background(Color.gray)
                .cornerRadius(15)
        }
        .padding()
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView(isFirstLaunching: .constant(true))
    }
}
