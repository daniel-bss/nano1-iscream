//
//  MonsterView.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 26/03/23.
//

import SwiftUI

struct MonsterView: View {
    @ObservedObject var audioRecorder: AudioRecorder
    
    @State var healthStatus: Int = 0
    @State var power: Float = 0
    @State var monsterId: Int = Int.random(in: 0...14)
    
    @State var startScreamingCounter: Int = 3
    @State var startScreamingText: String = "Start Screaming in"
    @State var textGO: String = "GO!"
    @State var isStarted: Bool = false
    @State var boxImage: String = "startscreaming"
    
    @State var timer: Int = 60
    
    @State var isDefeated: Bool = false
    
    @Binding var playerId: Int
    
    @Binding var showLeaderboard: Bool
    
    var barWidth: Double = 322.0
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
                .aspectRatio(contentMode: .fill)
            
            // ================================================================
            if (startScreamingCounter != 0) {
                ZStack {
                    Image(boxImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 380)
                        .padding(.top, -300)
                    VStack {
                        Text(startScreamingText)
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .font(.title)
                            .padding(.top, -270)

                        Text(String(startScreamingCounter))
                            .foregroundColor(Color(red: 237/255.0, green: 96/255.0, blue: 70/255.0))
                            .fontWeight(.bold)
                            .font(.system(size: 100))
                            .padding(.top, -245)
                            .onAppear(perform: {
                                var t: Double = 1.0
                                for _ in 1...3 {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + t) {
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        startScreamingCounter -= 1
                                    }
                                    t += 1
                                }
                            })
                    }
                    .padding(.top, 100)
                }
            }
            else {
                ZStack {
                    Image(boxImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 380)
                        .padding(.top, -300)
                    VStack {
                        Text(textGO)
                            .foregroundColor(Color(red: 237/255.0, green: 96/255.0, blue: 70/255.0))
                            .fontWeight(.bold)
                            .font(.system(size: 100))
                            .padding(.top, -245)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                    textGO = ""
                                    startScreamingText = ""
                                    boxImage = ""
                                    isStarted = true

                                    audioRecorder.startRecording()
                                }
                            }
                    }
                    .padding(.top, 100)
                }
            }
            
            // ================================================================

            
//            if true {
            if isStarted {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.white)
                        .frame(width: 200, height: 100)
                        .padding(.top, -315)
                    
                    Image(systemName: "clock")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .font(.system(size: 50))
                        .padding(.top, -296)
                        .padding(.leading, -85)
                    
                        Text(String(timer))
                            .foregroundColor(Color(red: 237/255.0, green: 96/255.0, blue: 70/255.0))
                            .fontWeight(.bold)
                            .font(.system(size: 85))
                            .padding(.top, -315)
                            .padding(.leading, 70)
                            .onAppear(perform: {
                                var t: Double = 1.0
                                for _ in 1...60 {
//                                for _ in 1...10 { //TESTING
                                    DispatchQueue.main.asyncAfter(deadline: .now() + t) {
                                        timer -= 1
                                    }
                                    t += 1
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + t) {
                                    audioRecorder.stopRecording()
                                    showLeaderboard = true
                                }
                            })
                }
                .padding(.trailing, 35)
                
                if !isDefeated {
                    Image("monster\(String(monsterId))")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300)
                        .padding(.trailing, 35)
                    
                    HealthBar(healthStatus: $healthStatus, monsterId: $monsterId, isDefeated: $isDefeated, playerId: $playerId)
                        .padding(.trailing, 35)
                } else {
                    Image("poof")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 400)
                        .padding(.top, -100)
                        .padding(.trailing)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                isDefeated = false
                            }
                        }
                }
                // BOTTOM WHITE BAR
                ZStack {
                    RoundedRectangle(cornerRadius: 42)
                        .fill(.white)
                        .frame(width: .infinity, height: 288)

                    Image("Bar")
                        .padding(.bottom, 120)

                    // BAR POINTER
                    BarPointerView(audioRecorder: audioRecorder, power: $power,  healthStatus: $healthStatus, barWidth: barWidth)

                    // DECIBELS TEXT
                    DecibelsTextView(power: $power)
                }
                .padding(.top, 630)
                .padding(.trailing, 35)
            }
        }
    }
}
