//
//  ContentView.swift
//  AiApp
//
//  Created by Domenico Cafarelli on 15/01/23.
//

import Foundation
import SwiftyJSON
import Alamofire
import SwiftUI


struct ResponseData: Codable {
    let choices: [Choice]
}

struct Choice: Codable {
    let text: String
}


struct ContentView: View {
    @State private var requestToTheAiText = ""
    @State private var responseFromAi = ""
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            TextField("Insert your request", text: $requestToTheAiText)
                .padding()
                .border(Color.gray)
            
            Button(action: {
                self.isLoading = true
                // save requestToTheAiText to a variable
                let request = self.requestToTheAiText
                
                // Send request to API
                let parameters: [String: Any] = ["prompt": request, "model": "text-davinci-002"]
                let headers: HTTPHeaders = ["Content-Type": "application/json", "Authorization": "Bearer <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>"]
                
                AF.request("https://api.openai.com/v1/engines/davinci/completions",
                           method: .post,
                           parameters: parameters,
                           headers: headers)
                .responseDecodable(of: ResponseData.self) { response in
                    if let data = response.data {
                        print(String(data: data, encoding: .utf8) ?? "")
                    }
                    switch response.result {
                    case .success(let data):
                        self.responseFromAi = data.choices[0].text
                    case .failure(let error):
                        self.responseFromAi = "Error: \(error.localizedDescription)"
                    }
                    self.isLoading = false
                }
                
            }) {
                Text("Send Request")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            if isLoading {
                ActivityIndicator(isAnimating: $isLoading, style: .large)
            } else {
                Text("Response: \(responseFromAi)").multilineTextAlignment(.leading)
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}


