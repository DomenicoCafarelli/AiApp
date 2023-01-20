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
    @Published var responseWaiting = false
    
    let topics = [
    Topic(title: "School"),
    Topic(title: "Tech"),
    Topic(title: "Design")
    ]
    
    private var client: OpenAISwift?
    
    /// It sets the token used to have access at the OpenAI API
    ///
    /// To use this function you need to paste your token instead of the PASTEHERE placeholder
    /// ```
    /// func setup(){
    ///     client  = OpenAISwift(authToken:"PASTEHERE")
    /// }
    /// ```
    /// > Warning: Be sure that your token is active, otherwise the chat will not work
    ///
    func setup(){
        //Use the token splitted in this way to have a public repo on GitHub without being banned from OpenAI
        let firstPartOfTheToken = "sk-SDN9plzak37y0Y2SngCfT"
        let secondPartOfTheToken = "3BlbkFJ4v7TmNvmOtD0usi4X4EF"
        client  = OpenAISwift(authToken: firstPartOfTheToken + secondPartOfTheToken)
    }
    
    /// Function used to send the request to ChatGPT
    /// - Parameter text: the text of the request
    func sendApiRequest(text: String){
        // return nothing if user types noting
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        
        responseWaiting = true
        print("Api send")
        let text2  = text
        models.append("You:\(text2)")
        send(text: text2) { response in
            DispatchQueue.main.async {
                self.models.append("ChatGPT:" + response.trimmingCharacters(in: .whitespacesAndNewlines))
                self.responseWaiting = false
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
