//
//  WelcomeView.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 26/03/23.
//

import SwiftUI

struct WelcomeView: View {
    @Binding var isStarted: Bool
    @State var username: String = ""
    @State var isTappedToStart: Bool = false
//    @ObservedObject var player: Player
    @Binding var playerId: Int
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
                .aspectRatio(contentMode: .fill)
            
            // ISCREAM LOGO
            Image("welcomelogo")
                .padding(.top, -290)
            
            
            // INPUT USERNAME
            if isTappedToStart {
                HStack {
                    TextField("Your name here!", text: $username)
                    
                    // ENTER BUTTON ✅
                    Button {
                        playerId = players.count + 1
                        players.append(Player(
                            id: playerId,
                            name: username,
                            kills: 0)
                        )
                        isStarted.toggle()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color(red: 166/255.0, green: 168/255.0, blue: 21/255.0))
                                .frame(width: 37, height: 37)
                                .padding(.trailing, -7)
                                .padding(.vertical, -10)
                            Image(systemName: "checkmark")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .font(.system(size: 21))
                                .padding(.trailing, -7)
                        }
                    }
                }
                .foregroundColor(.black)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(red: 120/255.0, green: 122/255.0, blue: 0/255.0), lineWidth: 4))
                .padding(7)
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal, 50)
                .fontWeight(.bold)
            }
            
                // TAP TO START
            if !isTappedToStart {
                Button {
                    self.isTappedToStart.toggle()
                } label: {
                    ZStack {
                        Image("taptostart")
                        Text("Tap to Start!")
                            .font(.system(size: 32))
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 120/255.0, green: 122/255.0, blue: 0/255.0))
                    }
                    .padding(.top, 450)
                }
            }
        }
    }
}
