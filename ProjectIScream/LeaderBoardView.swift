//
//  LeaderBoardView.swift
//  Leaderboard
//
//  Created by Jonathan Axel Benaya on 23/03/23.
//

import SwiftUI

struct LeaderBoardView: View {
    @State var players: [Player]
    @State var sortedPlayers: [Player] = []
    @Binding var isStarted: Bool
    @Binding var showLeaderboard: Bool
    
    @State var count : Int = 0
    
    var body: some View {
        ZStack {
            Color("Hijau Tua")
                .ignoresSafeArea()
            
            ScrollView {
                
                HStack {
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [
                            Color(red: 255/255.0, green: 215/255.0, blue: 116/255.0),
                            Color(red: 255/255.0, green: 255/255.0, blue: 214/255.0)
                        ]),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                        .frame(width: .infinity, height: 80)
                        .cornerRadius(10)
                        .padding(.horizontal, 5)
//                        .padding(.vertical, 100)
                        HStack {
                            Text("  Leaderboard 🏆")
                                .fontWeight(.bold)
                                .font(.system(size: 40))
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .onAppear {
                            players = players.sorted {$0.kills > $1.kills}
                        }
                    }
                }
                
                VStack {
                    ForEach(0 ..< players.count) { index in
                        var playerKills = players[index].kills
                        HStack {
                            VStack(alignment : .leading){
                                Text("\(players[index].name)")
                                    .bold()
                                    .foregroundColor(Color("Merah"))
                                    .font(.system(size: 28))
                                Text("\(playerKills) \((playerKills > 1) ? "kills" : "kill") ☠️")
                                    .bold()
                                    .font(.system(size: 23))
                                    .padding(.top, -14)
                            }
                            Spacer()
                            if index == 0 {
                                Image("Leaderboard 1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 130)
                                    .padding(-50)
                                    .padding(.trailing, 15)
                            }
                            if index == 1 {
                                Image("Leaderboard 2")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 130)
                                    .padding(-50)
                                    .padding(.trailing, 15)
                            }
                            if index == 2 {
                                Image("Leaderboard 3")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 130)
                                    .padding(-50)
                                    .padding(.trailing, 15)
                            }
                        }
//                        .frame(minHeight: 10)
                    }
                    .padding()
                    .background(Color(.white))
                    .cornerRadius(10)
                    .shadow(radius: 20)
                }
                .padding(.horizontal, 10)
                .padding(.top, -20)
            }
            
            VStack {
                Button {
                    self.isStarted = false
                    self.showLeaderboard = false
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color(red: 188/255.0, green: 214/255.0, blue: 42/255.0))
                            .frame(width: 75, height: 75)
                            .padding(.trailing, -7)
                            .padding(.vertical, -10)
                        Image(systemName: "house")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: 33))
                            .padding(.trailing, -7)
                    }
                    .shadow(radius: 35)
                    .padding(.top, 630)
                    .padding(.leading, 250)
                }

            }
        }
        
    }
    
}
//
//struct LeaderBoardView_Previews: PreviewProvider {
//    static var previews: some View {
//        LeaderBoardView(savedPlayers: .constant([Player(name: "Axel", result: 75.55)]))
//    }
//}

