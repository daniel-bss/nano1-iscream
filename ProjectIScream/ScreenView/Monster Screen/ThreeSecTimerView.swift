//
//  ThreeSecTimerView.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 14/02/24.
//

import SwiftUI
import Combine

struct ThreeSecTimerView: View {
    
//    var timer: Publishers.Autoconnect<Timer.TimerPublisher>
    @Binding var threeSecTimer: Int
    
    var body: some View {
        ZStack {
            RoundedRectangleBlockView()
            
            VStack(spacing: 10) {
                if threeSecTimer != 0 {
                    Text("Start screaming in")
                        .font(.system(size: 26))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Text("\(threeSecTimer)")
                        .font(.system(size: 85))
                        .fontWeight(.heavy)
                        .foregroundColor(.customLightRed)
                } else {
                    Text("GO!")
                        .font(.system(size: 80))
                        .fontWeight(.heavy)
                        .foregroundColor(.customLightRed)
                }
                
            }
        }
    }
}

//#Preview {
//    ThreeSecTimerView(threeSecTimer: 3)
//}
