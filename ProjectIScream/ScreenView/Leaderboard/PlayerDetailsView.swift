//
//  PlayerDetailsView.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 13/02/24.
//

import SwiftUI

struct PlayerDetailsView: View {
    
    let name: String
    let kills: Int
    let index: Int
    
    var body: some View {
        HStack {
            VStack(alignment : .leading){
                Text(name)
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                    .foregroundColor(Color.red)
                Text("\(kills) \((kills > 1) ? "kills" : "kill") ☠️")
                    .bold()
                    .font(.system(size: 23))
                    .padding(.top, -14)
            }
            
            Spacer()
            
            if index == 0 {
                LeaderboardImage(name: "leaderboard-1")
            } else if index == 1 {
                LeaderboardImage(name: "leaderboard-2")
            } else if index == 2 {
                LeaderboardImage(name: "leaderboard-3")
            }
        }
        .padding()
        .background(Color(.white))
        .cornerRadius(10)
        .shadow(radius: 20)
    }
}

#Preview {
    PlayerDetailsView(name: "Dummy", kills: 999, index: 0)
}
