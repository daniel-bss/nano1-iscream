//
//  TopRoundedRectangle.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 13/02/24.
//

import SwiftUI
import UIKit

struct TopRoundedRectangle: UIViewRepresentable {
    
    let color: Color
    let r: CGFloat
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = UIColor(color)
        view.layer.cornerRadius = r
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
}

struct TopRoundedRectangle2: View {
    var body: some View {
        TopRoundedRectangle(color: Color.blue, r: 200)
            .frame(width: 200, height: 200)
    }
}

#Preview {
    TopRoundedRectangle2()
}
