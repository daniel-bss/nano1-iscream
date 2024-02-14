//
//  TapToStartButton.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 13/02/24.
//

import SwiftUI

struct TapToStartButton: View {
    var body: some View {
        Text("Tap to Start!")
            .font(.system(size: 32))
            .fontWeight(.bold)
            .foregroundColor(Color("customLightGreen"))
    }
}

#Preview {
    TapToStartButton()
}
