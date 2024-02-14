//
//  BackButton.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 13/02/24.
//

import SwiftUI

struct BackButton: View {
    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 23)
            
            Text("Back")
                .font(.system(size: 20))
        }
        .foregroundColor(.customLightGreen)
        .frame(width: 100, height: 50)
        .background(.white)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 25, height: 10)))
    }
}

#Preview {
    BackButton()
}
