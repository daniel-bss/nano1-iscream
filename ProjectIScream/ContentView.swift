//
//  ContentView.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 25/03/23.
//

import SwiftUI

struct Player: Hashable {
    let id: Int
    let name: String
    let kills: Int
}

struct ContentView: View {
    @StateObject var audioRecorder = AudioRecorder()
    @State var healthStatus: Int = 0
    @State var power: Float = 0
    var barWidth: Double = 322.0
    @State var monsterId: Int = Int.random(in: 0...6)
//    let player: Player

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
                .aspectRatio(contentMode: .fit)
            
            Image("monster\(String(monsterId))")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 288)
            
            HealthBar(healthStatus: $healthStatus, monsterId: $monsterId)
            
            // BOTTOM WHITE BAR
            ZStack {
                RoundedRectangle(cornerRadius: 42)
                    .fill(.white)
                    .frame(width: .infinity, height: 288)
                
                Image("Bar")
                    .padding(.bottom, 120)
                
                // BAR POINTER
                BarPointerView(barWidth: barWidth, power: $power, audioRecorder: audioRecorder, healthStatus: $healthStatus)
                
                // DECIBELS TEXT
                DecibelsTextView(power: $power)
                
            }
            .padding(.top, 630)
            
        }
        .onAppear {
            audioRecorder.startRecording()
//            player = Player(id: 1, name: "asd", kills: 12)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
