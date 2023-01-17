//
//  ButtonTopicSelection.swift
//  AiApp
//
//  Created by Vincenzo Pascarella on 17/01/23.
//

import SwiftUI

struct ButtonTopicSelection: View {
    let text: String
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: UIScreen.main.bounds.size.width/1.5, height: UIScreen.main.bounds.size.height/8)
                .foregroundColor(.blue)
            Text(text)
                .foregroundColor(.white)
                .font(.title2)
        }
        .cornerRadius(15)
    }
}

struct ButtonTopicSelection_Previews: PreviewProvider {
    static var previews: some View {
        ButtonTopicSelection(text: "Prova")
    }
}
