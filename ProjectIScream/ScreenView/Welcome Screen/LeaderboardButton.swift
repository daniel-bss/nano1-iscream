//
//  LeaderboardButton.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 15/02/24.
//

import SwiftUI

struct LeaderboardButton: View {
    var body: some View {
        HStack {
            Spacer()
            
            HStack(spacing: 10) {
                Image(systemName: "list.number")
                    .symbolRenderingMode(.palette)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.red, .purple)
                    .frame(width: 30, height: 30)
                
                Text("Leaderboard")
                    .foregroundColor(.black)
                    .font(.system(size: 19))
                    .fontWeight(.semibold)
            }
            .frame(width: 190, height: 48)
            .background(Color.customYellow)
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.customLightBlue, lineWidth: 4)
            )
        }
    }
}

#Preview {
    LeaderboardButton()
}
