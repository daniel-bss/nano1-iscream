//
//  ContentView.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 25/03/23.
//

import SwiftUI


//class Player: ObservableObject {
//    @Published var id: Int
//    @Published var name: String
//    @Published var kills: Int
//
//    init(id: Int, name: String, kills: Int) {
//        self.id = id
//        self.name = name
//        self.kills = kills
//    }
//
//    convenience init() {
//        self.init(id: 999, name: "johndoe", kills: 123)
//    }
//}

struct Player {
    var id: Int
    var name: String
    var kills: Int
    
    mutating func addKill() -> Void {
        self.kills += 1
    }
}

// Players for leaderboard
//var players: [Player] = []
var players: [Player] = [
//    Player(id: 1, name: "daniel", kills: 12),
//    Player(id: 2, name: "bernard", kills: 32),
//    Player(id: 3, name: "sahala", kills: 1),
//    Player(id: 4, name: "simamora", kills: 51),
//    Player(id: 5, name: "qwert", kills: 33),
//    Player(id: 6, name: "asdf", kills: 0)
]


struct ContentView: View {
    @StateObject var audioRecorder = AudioRecorder()
    @State var isStarted: Bool = false
    @State var showLeaderboard: Bool = false
    @State var playerId: Int = 999
    
    var body: some View {
        ZStack {
            
            if (!isStarted && !showLeaderboard) {
                WelcomeView(isStarted: $isStarted, playerId: $playerId)
            } else if (isStarted && !showLeaderboard) {
                MonsterView(audioRecorder: audioRecorder, playerId: $playerId, showLeaderboard: $showLeaderboard)
            } else if showLeaderboard {
                LeaderBoardView(players: players, isStarted: $isStarted, showLeaderboard: $showLeaderboard)
            }
            
            
//            WelcomeView(isStarted: $isStarted, playerId: $playerId)
//            MonsterView(audioRecorder: audioRecorder, playerId: $playerId, showLeaderboard: $showLeaderboard)
//            LeaderBoardView(players: players, isStarted: $isStarted, showLeaderboard: $showLeaderboard)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
