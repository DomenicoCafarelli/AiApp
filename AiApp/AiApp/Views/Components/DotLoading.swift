//
//  DotLoading.swift
//  AiApp
//
//  Created by Vincenzo Pascarella on 17/01/23.
//

import SwiftUI

struct DotLoading: View {
    var body: some View {
        HStack {
            DotView() // 1.
            DotView(delay: 0.2) // 2.
            DotView(delay: 0.4) // 3.
        }
    }
    
    private struct DotView: View {
        @State var delay: Double = 0 // 1.
        @State var scale: CGFloat = 0.5
        var body: some View {
            Circle()
                .frame(width: 70, height: 70)
                .scaleEffect(scale)
//                .animation(Animation.easeInOut(duration: 0.6).repeatForever().delay(delay)) // 2.
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.6).repeatForever().delay(delay)) {
                        self.scale = 1
                    }
                }
        }
    }

}
