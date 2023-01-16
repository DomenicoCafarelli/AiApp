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
    
    private var client: OpenAISwift?
    
    // setting up the client req
    func setup(){
        client  = OpenAISwift(authToken:"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")
    }
    
    // sending api text to server
    func send(text: String, completion: @escaping (String)->Void){
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
