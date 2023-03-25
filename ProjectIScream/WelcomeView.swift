//
//  WelcomeView.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 26/03/23.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
                .aspectRatio(contentMode: .fill)
            
            VStack {
                Image("welcomelogo")
                    .padding(.bottom, 110)
                
                ZStack {
                    Image("taptostart")
                    Text("Tap to Start!")
                        .font(.system(size: 32))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 120/255.0, green: 122/255.0, blue: 0/255.0))
                }
                .padding(.top, 120)
                
            }
            .padding(.top, 30)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
