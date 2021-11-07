//
//  CustomButton.swift
//  Medical
//
//  Created by 于争光 on 2021/10/16.
//

import SwiftUI


struct ButtonStyles: ButtonStyle {
    var bgColor: Color
    
    init(bgColor: Color = .blue){
        self.bgColor = bgColor
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .frame(maxWidth:.infinity)
            .frame(height: 40)
            .background(bgColor)
            .cornerRadius(5)
    }
}


extension Button{
    func customButtom(bgColor:Color) -> some View {
        self.buttonStyle(ButtonStyles(bgColor:bgColor))
    }
}
