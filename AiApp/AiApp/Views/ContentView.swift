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
    @State private var responseWaiting = false
    
    var body: some View {
        VStack(alignment: .center) {
            ScrollViewReader{ proxy in
                ScrollView (.vertical, showsIndicators: true) {
                    ForEach(viewModel.models, id: \.self.hashValue) { string in
                        if string.contains("You"){
                            VStack{
                                Text("You")
                                    .font(.system(size: 16.0))
                                    .foregroundColor(.blue)
                                    .frame(width: UIScreen.main.bounds.width-20, alignment: .trailing)
                                //.padding(.bottom, -10)
                                
                                Text(string.replacing("You:", with: ""))
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(responseWaiting ? Color.red : Color.blue)
                                    .cornerRadius(10)
                                    .frame(width: UIScreen.main.bounds.width-20, alignment: .trailing)
                                
                            }//VStack
                            .padding(.bottom, 10)
                            //DEBUG
                            .onTapGesture {
                                print(viewModel.models)
                                print(viewModel.responseWaiting)
                            }
                            
                        } else {
                            if (viewModel.models.last != string){
                                VStack{
                                    Text("ChatGPT")
                                        .font(.system(size: 16.0))
                                        .foregroundColor(.green)
                                        .frame(width: UIScreen.main.bounds.width-20, alignment: .leading)
                                    //.padding(.bottom, -10)
                                    
                                    Text(string.replacing("ChatGPT:", with: ""))
                                        .foregroundColor(.primary)
                                        .padding(10)
                                        .background(Color(UIColor.systemGray5))
                                        .cornerRadius(10)
                                        .frame(width: UIScreen.main.bounds.width-20, alignment: .leading)
                                    
                                }//Vstack
                            }
                        }//else
                        
                    }//ForEach
                    
                    if responseWaiting{
                        HStack{
                            DotLoading().scaleEffect(0.3, anchor: .leading)
                        }
                        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                    } else {
                        VStack{
                            Text("ChatGPT")
                                .font(.system(size: 16.0))
                                .foregroundColor(.green)
                                .frame(width: UIScreen.main.bounds.width-20, alignment: .leading)
                            //.padding(.bottom, -10)
                            
                            Text(viewModel.models.last?.replacing("ChatGPT:", with: "") ?? "")
                                .foregroundColor(.primary)
                                .padding(10)
                                .background(Color(UIColor.systemGray5))
                                .cornerRadius(10)
                                .frame(width: UIScreen.main.bounds.width-20, alignment: .leading)
                            
                        }//Vstack
                    }
                    
                    Spacer().id(bottomID)

                }//ScrollView
                .onChange(of: viewModel.models.last) { _ in
                    withAnimation(.easeInOut(duration: 0.5)) {
                        responseWaiting = viewModel.responseWaiting
                    }
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
                    .cornerRadius(100)
                    .background(RoundedRectangle(cornerRadius: 100, style: .continuous)
                        .stroke(.gray.opacity(0.6), lineWidth: 1.5))
                
                Button{
                    responseWaiting = true
                    viewModel.sendApiRequest(text: text)
                    text = ""
                    self.hideKeyboard()
                }label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 35))
                        .foregroundColor(.blue)
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
        .onTapGesture {
            self.hideKeyboard()
        }
        
    }//body
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(title: "SchoolProva")
            .environmentObject(ChatGPTViewModel())
    }
}
