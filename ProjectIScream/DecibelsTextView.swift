//
//  DecibelsTextView.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 25/03/23.
//

import SwiftUI

struct DecibelsTextView: View {
    @Binding var power: Float
    
    var body: some View {
        HStack(spacing: 0) {
            Text("\(String(format: "%.2fdb", power))")
                .foregroundColor(Color(red: 179/255.0, green: 1/255.0, blue: 0/255.0))
                .fontWeight(.bold)
                .font(.system(size: 34))
            Text("!!")
                .foregroundColor(Color(red: 237/255.0, green: 21/255.0, blue: 0/255.0))
                .fontWeight(.bold)
                .font(.system(size: 34))
        }
        .padding(.top, 30)
    }
}
