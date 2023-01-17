//
//  MainView.swift
//  AiApp
//
//  Created by Vincenzo Pascarella on 17/01/23.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: ChatGPTViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                
                ForEach(viewModel.topics){ topic in
                    
                    NavigationLink {
                        ContentView(title: topic.title)
                    } label: {
                        ButtonTopicSelection(text: topic.title)
                    }
                    
                    Spacer()
                }
                
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ChatGPTViewModel())
    }
}
