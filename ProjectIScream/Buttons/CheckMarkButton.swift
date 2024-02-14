//
//  CheckMarkButton.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 13/02/24.
//

import SwiftUI

struct CheckMarkButton: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.customLightGreen2)
                .frame(width: 45, height: 45)
            Image(systemName: "checkmark")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.system(size: 21))
        }
    }
}

#Preview {
    CheckMarkButton()
}
