//
//  BarPointerView.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 25/03/23.
//

import SwiftUI

struct BarPointerView: View {
    var barWidth: Double
    @Binding var power: Float
    @ObservedObject var audioRecorder: AudioRecorder
    
    @Binding var healthStatus: Int
    @State var dbContainer: [Float] = []
    
    var body: some View {
        Image(systemName: "arrowtriangle.up.fill")
            .resizable()
            .frame(width: 25, height: 50)
            .padding(.bottom, 70)
            .foregroundColor(.black)
            .padding(.leading, (power == 0 ? (0 - CGFloat(barWidth/2.0)) : (0 - CGFloat(barWidth/2.0) - 40 + CGFloat(power * 1.5))) )
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                    power = audioRecorder.peakPower
                    
                    // detect when user is screaming
                    if (power >= 90.0) {
                        dbContainer.append(power)

                        // user's been screaming for 2 seconds (i.e., 0.01 * 200)
                        if (dbContainer.count >= 200) {
                            print("masuk if 2")
                            healthStatus += 1
                            dbContainer.removeAll()
                        }
                    } else { // user is not screaming anymore
                        dbContainer.removeAll()
                    }
                }
            }
    }
}

