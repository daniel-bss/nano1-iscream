//
//  LeaderboardImage.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 13/02/24.
//

import SwiftUI

struct LeaderboardImage: View {
    
    let name: String
    
    var body: some View {
        Image(name)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 130)
            .padding(-50)
            .padding(.trailing, 15)
    }
}

#Preview {
    LeaderboardImage(name: "leaderboard-1")
}
