//
//  TimerView.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 13/02/24.
//

import SwiftUI
import Combine

struct TimerView: View {
    
//    let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    @Binding var timeSec: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 22, height: 22))
                .foregroundColor(.customLightGray2)
                .frame(width: 180, height: 100)
                .padding(.top, 15)
            
            RoundedRectangle(cornerSize: CGSize(width: 22, height: 22))
                .foregroundColor(.white)
                .frame(width: 180, height: 100)
            
            HStack(spacing: 10) {
                Image(systemName: "clock")
                    .fontWeight(.semibold)
                Text(timeSec.description)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.customLightRed)
            }
            .font(.system(size: 49))
        }
    }
}

//#Preview {
//    TimerView(timeSec: .constant(60))
//}
