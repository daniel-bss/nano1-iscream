//
//  TextFieldModifier.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 13/02/24.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .submitLabel(.done)
            .font(.system(size: 24))
            .frame(width: 200, height: 16)
            .padding()
            .background(Color.customLightGray)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 7, height: 10)))
    }
}

