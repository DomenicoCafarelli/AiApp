//
//  ContentView.swift
//  AiApp
//
//  Created by Vincenzo Pascarella on 16/01/23.
//

import OpenAISwift
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ChatGPTViewModel()
    
    @State var text = ""
    @State var models  = [String]()
    
    var body: some View {
        VStack(alignment: .center) {
            VStack{
                Text("DC forced me to copy-paste")
                    .font(.system(.title2))
                    .fontWeight(.bold)
                    .foregroundColor(Color("me"))
            }
            .frame(width: UIScreen.main.bounds.width)
            .background(Color("bg"))
            
            ScrollView (.vertical, showsIndicators: true) {
                ForEach(models, id: \.self.hashValue) { string in
                    if string.contains("You"){
                        VStack{
                            Text("You")
                                .font(.system(size: 12.0))
                                .foregroundColor(.blue.opacity(0.6))
                                .frame(width: UIScreen.main.bounds.width-20, alignment: .trailing)
//                                .padding(.bottom, -10)
                            
                            Text(string.replacing("You:", with: ""))
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color("me"))
                                .cornerRadius(10)
                                .frame(width: UIScreen.main.bounds.width-20, alignment: .trailing)
                            
                        }.padding(.bottom, 10)
                        
                    }else{
                        VStack{
                            Text("ChatGPT")
                                .font(.system(size: 12.0))
                                .foregroundColor(.red.opacity(0.6))
                                .frame(width: UIScreen.main.bounds.width-20, alignment: .leading)
//                                .padding(.bottom, -10)
                            
                            Text(string.replacing("ChatGPT:", with: ""))
                                .foregroundColor(.primary)
                                .padding(10)
                                .background(Color("bot"))
                                .cornerRadius(10)
                                .frame(width: UIScreen.main.bounds.width-20, alignment: .leading)
                            
                        }
                        
                    }
                    
                }
                
            }
            
            HStack(alignment: .center, spacing: 2){
                Button{
                    print("Broooo")
                }label: {
                    Image(systemName: "camera")
                        .font(.system(size: 25))
                        .foregroundColor(Color("icon"))
                }
                .padding(5)
                .cornerRadius(100)
                TextField("Type here ...", text: $text)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    .background(Color("textBox"))
                    .cornerRadius(100)
                    .background(RoundedRectangle(cornerRadius: 100, style: .continuous)
                        .stroke(.gray.opacity(0.6), lineWidth: 1.5))
                
                Button{
                    sendApiRequest()
                }label: {
                    Image(systemName: "paperplane")
                        .font(.system(size: 25))
                        .foregroundColor(Color("icon"))
                }
                .padding(5)
                .cornerRadius(100)
            }
        }
        .padding(10)
        .onAppear{
            viewModel.setup()
        }.background(Color("bg"))
    }
    
    func sendApiRequest(){
        // return nothing if user types noting
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        let text2  = self.text
        self.text = ""
        models.append("You:\(text2)")
        
        viewModel.send(text: text2) { response in
            DispatchQueue.main.async {
                self.models.append("ChatGPT:" + response.trimmingCharacters(in: .whitespacesAndNewlines))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
