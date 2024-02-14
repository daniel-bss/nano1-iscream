//
//  LeaderboardHeaderView.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 13/02/24.
//

import SwiftUI

struct LeaderboardHeaderView: View {
    
    var body: some View {
        HStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 255/255.0, green: 215/255.0, blue: 116/255.0),
                        Color(red: 255/255.0, green: 255/255.0, blue: 214/255.0)
                    ]),
                   startPoint: .leading,
                   endPoint: .trailing
                )
                .frame(width: UIScreen.main.bounds.width, height: 80)
                .cornerRadius(10)
                .padding(.horizontal, 5)
                
                HStack {
                    Text("Leaderboard 🏆")
                        .fontWeight(.bold)
                        .font(.system(size: 40))
                        .foregroundColor(.black)
                        .padding(.leading, 20)
                    Spacer()
                }
            }
        }
    }
    
}

#Preview {
    LeaderboardHeaderView()
}
