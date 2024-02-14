//
//  LeaderBoardView.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 13/02/24.
//

import SwiftUI

struct LeaderBoardView: View {
    
    @ObservedObject var vm: AppViewModel
    
    var body: some View {
        ZStack {
            Color.customDarkGreen
                .ignoresSafeArea()
            
            ScrollView {
                LeaderboardHeaderView()
                    .padding(.bottom, 8)
                
                VStack {
                    ForEach(0..<vm.sortedPlayers.count) { index in
                        let player = vm.sortedPlayers[index]
                        
                        PlayerDetailsView(
                            name: player.name,
                            kills: player.kills,
                            index: index // to determine 1/2/3 Rank
                        )
                    }
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: 60)
                }
                .padding(.horizontal, 12)
            }
            
            VStack {
                Spacer()
                
                ZStack {
                    Rectangle()
                        .frame(height: 90)
                        .foregroundStyle(.ultraThinMaterial)
                    
                    Button(action: {
                        vm.isShowingWelcomeView = true
                        vm.isShowingMonsters = false
                    }, label: {
                        HStack {
                            Label("Back", systemImage: "house.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }
                        .frame(width: 130, height: 50)
                        .background(Color.customDarkGreen)
                        .cornerRadius(13)
                    })
                    .offset(y: -10)
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    LeaderBoardView(vm: AppViewModel())
}
