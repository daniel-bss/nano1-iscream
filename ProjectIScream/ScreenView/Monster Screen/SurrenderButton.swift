//
//  SurrenderButton.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 14/02/24.
//

import SwiftUI

struct SurrenderButton: View {
    
    var completion: () -> ()
    
    var body: some View {
        Button(action: {
            completion()
        }, label: {
            Text("Surrender")
                .font(.system(size: 17))
                .fontWeight(.bold)
                .foregroundColor(.black)
        })
        .frame(width: 110, height: 35)
        .background(.red)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    SurrenderButton(completion: {print("oke")})
}
