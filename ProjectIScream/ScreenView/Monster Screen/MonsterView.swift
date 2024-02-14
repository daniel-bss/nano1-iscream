//
//  MonsterView.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 13/02/24.
//

import SwiftUI

struct MonsterView: View {
    
    @ObservedObject var vm: AppViewModel    
    
    @State var decibelValue: CGFloat = 0
    @State var healthId = 0 // 0...6
    @State var monsterId = Int.random(in: 0...14)
    @State var rotationDegrees: Double = 0.0
    
    var body: some View {
        ZStack {
            if vm.isShowingThreeSecTimer {
                ThreeSecTimerView(threeSecTimer: $vm.threeSecTimer)
                    .padding(.bottom, 350)
            } else {
                // MONSTER
                if healthId == 7 {
                    Image("poof")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 210, height: 100)
                        .offset(y: 40)
                } else {
                    Image("monster-\(monsterId)")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100)
                        .shadow(color: .purple, radius: 50)
                        .offset(y: 40)
                        .rotationEffect(.degrees(rotationDegrees))
                }
                
                VStack {
                    HStack {
                        SurrenderButton {
                            vm.alertItem = AlertItem(title: "surrender", message: "", dismissButton: .default(Text("OK")))
                        }
                        .offset(x: -30)
                       
                        Text("\(vm.numOfKills) \(vm.numOfKills > 1 ? "KILLS" : "KILL")")
                            .font(.system(size: 35))
                            .fontWeight(.heavy)
                            .foregroundColor(Color.customLightRed)
                            .frame(width: 200, height:35)
                            .offset(x: 40)
                    }
                    .padding(.top, 70)
                    
                    TimerView(timeSec: $vm.timeSec)
                        .frame(width: 180, height: 100)
                        .padding(.top, 30)
                        .onAppear {
                            vm.isFinishedRecording = false
                            vm.startRecording()
                        }
                    
                    HealthBarView(healthId: $healthId)
                        .padding(.top, 45)
                    
                    Spacer()
                    
                    // BOTTOM WHITE BAR
                    ZStack {
                        TopRoundedRectangle(color: .white, r: 65)
                            .frame(height: 230)
                            .shadow(color: .black, radius: 100, x: 0.0, y: 30)
                        
                        // BAR INDICATOR
                        ZStack {
                            VStack(spacing: 25) {
                                Image("bar")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 325)
                                
                                HStack(spacing: 0) {
                                    Text("\(decibelValue, specifier: "%.2f")db")
                                        .foregroundColor(.customDarkRed)
                                    Text(" !!")
                                        .foregroundColor(.red)
                                }
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                            }
                            
                            Image(systemName: "arrowtriangle.up.fill")
                                .resizable()
                                .frame(width: 32, height: 55)
                                .foregroundColor(.customDarkBlack)
                                .padding(.bottom, 20)
                                .offset(x: self.getXOffset())
                        }
                        .padding(.bottom, 15)
                    }
                }
                .ignoresSafeArea()
            }
        }
        .onAppear {
            vm.setupTimer()
        }
        .onChange(of: vm.isFinishedRecording, perform: { value in
            if vm.isFinishedRecording {
                vm.stopRecording()
                vm.cancelTimer()                
            }
        })
        .onReceive(vm.$power, perform: { power in
            decibelValue = CGFloat(-1 * power)
            
            if decibelValue > 85 {
                vm.dbCounter += 1
            } else {
                rotationDegrees = 0
            }
            
            if vm.dbCounter == 80 {
                if healthId == 6 { // killed 1 monster
                    healthId += 1
                    vm.numOfKills += 1
                    
                    var randomId = Int.random(in: 0...14)
                    
                    while randomId == monsterId {
                        randomId = Int.random(in: 0...14)
                    }
                    
                    monsterId = randomId
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        healthId = 0
                    })
                    
                } else { // decrease health bar
                    healthId += 1
                    rotationDegrees = Double.random(in: -5...5)
                }
                
                // reset
                vm.dbCounter = 0
            }
        })
    }
    
    private func getXOffset() -> CGFloat {
        let value: CGFloat = (16 / 3) * (decibelValue - 70)
        let maximum = max(-160, value)
        let minimum = min(160, maximum)
        return CGFloat(minimum)
    }
}

#Preview {
    MonsterView(vm: AppViewModel())
}
