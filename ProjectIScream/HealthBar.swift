//
//  HealthBar.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 25/03/23.
//

import SwiftUI

struct HealthBarModifier: ViewModifier {
    @Binding var healthStatus: Int
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, 360)
    }
}

struct HealthBar: View {
    @Binding var healthStatus: Int
    var lineWidth: CGFloat = 4
    
    var body: some View {
        // Give border
        RoundedRectangle(cornerRadius: 25)
            .strokeBorder(.black, lineWidth: lineWidth)
            // .background(RoundedRectangle(cornerRadius: 25).fill(.gray))
            .frame(
                width: 140 + lineWidth * 2,
                height: 27 + lineWidth * 2
            )
            .padding(.bottom, 360)
        
        // Change Health Bar image
        if (healthStatus >= 0 && healthStatus <= 3) {
            // change health bar (0, 1, 2, 3)
            Image("health\(healthStatus)")
                .modifier(HealthBarModifier(healthStatus: $healthStatus))
                .padding(.leading, 0 - CGFloat(healthStatus * 20))
        } else if (healthStatus >= 4 && healthStatus <= 6) {
            // change health bar (4, 5, 6)
            Image("health\(healthStatus)")
                .padding(.bottom, 360)
                .padding(.leading, -70)
        } else {
            // if health is ZERO!
            Image("")
        }
    }
}
