//
//  AccessView.swift
//  li
//
//  Created by 박승찬 on 2023/09/03.
//

import SwiftUI

struct AccessView: View {
    var body: some View {
        VStack{
            Spacer()
            header
            Spacer()
            Spacer()
            Spacer()
            nextButton
        }
    }
}

extension AccessView {
    private var header: some View {
        Text("권한 어찌구\n주세요 ㅋㅋ")
            .font(.system(size: 32))
            .fontWeight(.semibold)
            .multilineTextAlignment(.center)
            .padding()
    }
    
    private var nextButton: some View {
        Button{
            print("AccessView: 다음버튼 클릭")
        } label: {
            Text("다음")
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

struct AccessView_Previews: PreviewProvider {
    static var previews: some View {
        AccessView()
    }
}
