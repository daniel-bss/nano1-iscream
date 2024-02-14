//
//  Extensions.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 13/02/24.
//

import SwiftUI

extension Color {
        
    static let customDarkGreen = Color("darkGreen")
    static let superLightGray = Color("superLightGray")
    
    static let customLightGreen = Color("customLightGreen")
    static let customLightGreen2 = Color(red: 166/255.0, green: 168/255.0, blue: 21/255.0)
    
    static let customLightGray = Color(red: 240/255, green: 240/255, blue: 240/255)
    static let customLightGray2 = Color(red: 200/255, green: 200/255, blue: 200/255)
    
    static let customDarkRed = Color(red: 179/255.0, green: 1/255.0, blue: 0/255.0)
    static let customLightRed = Color("customLightRed")
    
    static let customDarkBlack = Color("customDarkBlack")
    
    static let customYellow = Color("customYellow")
    static let customLightBlue = Color("customLightBlue")
    
}

extension Date {
    func toString( dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
