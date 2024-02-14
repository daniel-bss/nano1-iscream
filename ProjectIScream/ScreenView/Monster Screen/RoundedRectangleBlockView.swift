//
//  RoundedRectangleBlockView.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 14/02/24.
//

import SwiftUI

struct RoundedRectangleBlockView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 22)
                .frame(width: 260, height: 220)
                .foregroundColor(.customLightGray2)
                .padding(.top, 20)
            
            RoundedRectangle(cornerRadius: 22)
                .frame(width: 260, height: 220)
                .foregroundColor(.white)
                .shadow(radius: 20)
        }
    }
}

#Preview {
    RoundedRectangleBlockView()
}
