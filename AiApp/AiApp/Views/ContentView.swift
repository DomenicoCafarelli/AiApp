//
//  ContentView.swift
//  AiApp
//
//  Created by Vincenzo Pascarella on 16/01/23.
//

import OpenAISwift
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ChatGPTViewModel
    let title: String
    @State var text = ""
    @Namespace var bottomID
    
    var body: some View {
        VStack(alignment: .center) {
            ScrollViewReader{ proxy in
                ScrollView (.vertical, showsIndicators: true) {
                    ForEach(viewModel.models, id: \.self.hashValue) { string in
                        if string.contains("You"){
                            VStack{
                                Text("You")
                                    .font(.system(size: 12.0))
                                    .foregroundColor(.blue.opacity(0.6))
                                    .frame(width: UIScreen.main.bounds.width-20, alignment: .trailing)
                                //.padding(.bottom, -10)
                                
                                Text(string.replacing("You:", with: ""))
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(Color("me"))
                                    .cornerRadius(10)
                                    .frame(width: UIScreen.main.bounds.width-20, alignment: .trailing)
                                
                            }//VStack
                            .padding(.bottom, 10)
                            //DEBUG
                            .onTapGesture {
                                print(viewModel.models)
                            }
                            
                        } else {
                            
                            VStack{
                                Text("ChatGPT")
                                    .font(.system(size: 12.0))
                                    .foregroundColor(.red.opacity(0.6))
                                    .frame(width: UIScreen.main.bounds.width-20, alignment: .leading)
                                //.padding(.bottom, -10)
                                
                                Text(string.replacing("ChatGPT:", with: ""))
                                    .foregroundColor(.primary)
                                    .padding(10)
                                    .background(Color("bot"))
                                    .cornerRadius(10)
                                    .frame(width: UIScreen.main.bounds.width-20, alignment: .leading)
                                
                            }//Vstack
                            
                        }//else
                        
                    }//ForEach
                    Spacer().id(bottomID)

                }//ScrollView
                .onChange(of: viewModel.models.last) { _ in
                    proxy.scrollTo(bottomID)
                }
            }//ScrollViewReader
            
            HStack(alignment: .center, spacing: 2){
                
//                Button{
//                    print("Broooo")
//                }label: {
//                    Image(systemName: "camera")
//                        .font(.system(size: 25))
//                        .foregroundColor(Color("icon"))
//                }
//                .padding(5)
//                .cornerRadius(100)
                
                TextField("Type here ...", text: $text)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    .background(Color("textBox"))
                    .cornerRadius(100)
                    .background(RoundedRectangle(cornerRadius: 100, style: .continuous)
                        .stroke(.gray.opacity(0.6), lineWidth: 1.5))
                
                Button{
                    viewModel.sendApiRequest(text: text)
                    text = ""
                }label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 35))
                        .foregroundColor(Color("icon"))
                }//Button
                .padding(5)
                .cornerRadius(100)
            }//Hstack
            
        }//Vstack
        .navigationTitle(title)
        .padding(10)
        .onAppear{
            viewModel.setup()
        }
        .background(Color("bg"))
        
    }//body
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(title: "SchoolProva")
            .environmentObject(ChatGPTViewModel())
    }
}
