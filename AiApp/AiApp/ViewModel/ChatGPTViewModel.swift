//
//  ChatGPTViewModel.swift
//  AiApp
//
//  Created by Vincenzo Pascarella on 16/01/23.
//

import OpenAISwift
import SwiftUI

final class ChatGPTViewModel : ObservableObject {
    init() {}
    
    @Published var models = [String]()
    
    let topics = [
    Topic(title: "School"),
    Topic(title: "Tech"),
    Topic(title: "Design")
    ]
    
    private var client: OpenAISwift?
    
    // setting up the client req
    func setup(){
        client  = OpenAISwift(authToken:"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")
    }
    
    //Func that the view uses to send the request
    func sendApiRequest(text: String){
        // return nothing if user types noting
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        let text2  = text
        models.append("You:\(text2)")
        
        send(text: text2) { response in
            DispatchQueue.main.async {
                self.models.append("ChatGPT:" + response.trimmingCharacters(in: .whitespacesAndNewlines))
            }
        }
    }
    
    // sending api text to server
    private func send(text: String, completion: @escaping (String)->Void){
        client?.sendCompletion(with: text, maxTokens: 500, completionHandler: { result in
            
            switch result {
                // on request success
            case .success(let model):
                let output = model.choices.first?.text ?? ""
                completion(output)
                
                // on request fail
            case .failure: break
            }
            
        })
    }
    
    
    //Trying to implement a function to retrive the string of the token from a url where we change it
    func fetchStringFromWebsite(url: String) -> String {
        var token = String()
        guard let url = URL(string: url) else { return "Error"}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            let websiteString = String(data: data, encoding: .utf8)
            token = websiteString!
            print(websiteString!)
        }.resume()
        return token
    }
}
