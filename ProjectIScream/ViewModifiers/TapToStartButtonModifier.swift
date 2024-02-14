//
//  TapToStartButtonModifier.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 13/02/24.
//

import SwiftUI

struct TapToStartButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 280, height: 75)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 14, height: 0)))
            .shadow(radius: 7, x: 0, y: 11)
    }
}
