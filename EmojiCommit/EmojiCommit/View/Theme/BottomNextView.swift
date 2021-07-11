//
//  BottomNextView.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/04/06.
//

import SwiftUI

struct BottomNextView: View {
    
    private enum Constants {
        static let height: CGFloat = 59
    }
    
    let geometry: GeometryProxy
    let isNextEnabled: Bool
    
    var body: some View {
        Text("다음")
            .foregroundColor(Color.black)
            .frame(maxWidth: .infinity,
                   maxHeight: Constants.height,
                   alignment: .center)
            .padding(.bottom, geometry.safeAreaInsets.bottom)
            .background(isNextEnabled ? Color.yellow : Color.gray)
    }
}

struct BottomNextView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
           BottomNextView(geometry: geometry,
                          isNextEnabled: true)
        }
    }
}
