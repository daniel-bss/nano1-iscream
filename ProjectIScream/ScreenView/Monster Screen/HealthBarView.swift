//
//  HealthBarView.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 14/02/24.
//

import SwiftUI

struct HealthBarView: View {
    
    @Binding var healthId: Int
    
    var body: some View {
        HStack {
            if healthId != 7 {
                Image("health-\(healthId)")
                    .padding(.leading, healthId == 0 ? 8 : 0)
            }
            Spacer()
        }
        .frame(width: 140, height: 30)
        .background(.clear)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.black, lineWidth: 4)
        )
        .scaleEffect(1.1)
    }
}

#Preview {
    HealthBarView(healthId: .constant(0))
}
