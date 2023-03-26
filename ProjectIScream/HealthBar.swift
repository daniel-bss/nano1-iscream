//
//  HealthBar.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 25/03/23.
//

import SwiftUI

struct HealthBarModifier: ViewModifier {
    @Binding var healthStatus: Int
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, 330)
    }
}


struct HealthBar: View {
    @Binding var healthStatus: Int
    @Binding var monsterId: Int
    @Binding var isDefeated: Bool
    var lineWidth: CGFloat = 4
    
    @Binding var playerId: Int
    
    var body: some View {
        // Give border
        RoundedRectangle(cornerRadius: 25)
            .strokeBorder(.black, lineWidth: lineWidth)
            // .background(RoundedRectangle(cornerRadius: 25).fill(.gray))
            .frame(
                width: 140 + lineWidth * 2,
                height: 27 + lineWidth * 2
            )
            .padding(.bottom, 330)
        
        // Change Health Bar image
        if (healthStatus >= 0 && healthStatus <= 3) {
            // change health bar (0, 1, 2, 3)
            Image("health\(healthStatus)")
                .modifier(HealthBarModifier(healthStatus: $healthStatus))
                .padding(.leading, 0 - CGFloat(healthStatus * 20))
        } else if (healthStatus >= 4 && healthStatus <= 5) {
            // change health bar (4, 5, 6)
            Image("health\(healthStatus)")
                .modifier(HealthBarModifier(healthStatus: $healthStatus))
                .padding(.leading, -70)
        } else if (healthStatus == 6) {
            Image("health\(healthStatus)")
                .modifier(HealthBarModifier(healthStatus: $healthStatus))
                .padding(.leading, -70)
        } else {
            // if health is ZERO!
            Image("")
                .onAppear {
                    var newMonsterId = Int.random(in: 0...6)
                    while true {
                        if (monsterId == newMonsterId) {
                            newMonsterId = Int.random(in: 0...6)
                        } else {
                            monsterId = newMonsterId
                            break
                        }
                    }
                    healthStatus = 0
                    isDefeated = true
                    
                    for i in players.indices {
                        if players[i].id == playerId {
                            players[i].addKill()
                        }
                    }
                    print(players[playerId - 1])
                }
        }
    }
}
