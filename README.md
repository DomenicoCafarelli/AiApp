# AiApp

### Group

Development Dynamos is a group formed by

- 2 **Developers**
  - Domenico Cafarelli
  - Vincenzo Pascarella


- 2 **Project Managers**
  - Marco Cucci
  - Ivan Esposito

### Solution statement

> *An App for **iOS Developers** who wants to practice with Mock-Interviews*
> 

### Artefact Description

We have different goals 

- As **Group** we want to push until the 20th of January the app on App Store Connect.
- As **Developers** we want also to write a brief documentation to showcase our coding skills




## Code Documentation

Our project was built with SwiftUI Framework 

1. The first step is to import the Framework

```swift
import SwiftUI
```

2. Then we have to create the ContentView() to build our view

```swift
struct ContentView: View {
    var body: some View {
        
    }
}
```

At this point we will receive an error just because our body is empty, so to avoid this we have to put something inside. 

3. Let’s put inside the body a VStack{} 

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            // put inside the elements that you would like to show vertically
        }
    }
}
```

----------------------

### ChatGPTViewModel

This code defines a class called **`ChatGPTViewModel`**
 that is used to handle the logic for a chatbot application that uses OpenAI's GPT-3 model. The class inherits from **`ObservableObject`**
 and has the following properties and methods:

- **`init()`**: Initializes an instance of the class.

```swift
init() {}
```

- **`models`**: An array of strings that holds the chat history between the user and the chatbot. This property is marked with the **`@Published`** property wrapper, which means that any changes to it will trigger updates in any views that are observing it.

```swift
@Published var models = [String]()
```

- **`topics`**: An array of **`Topic`** objects that represents the topics the chatbot can handle.

```swift
let topics = [
    Topic(title: "School"),
    Topic(title: "Tech"),
    Topic(title: "Design")
    ]
```

- **`client`**: An optional instance of **`OpenAISwift`** that represents the connection to the OpenAI API.

```swift
private var client: OpenAISwift?
```

- **`setup()`**: Sets up the **`client`** instance by creating a new **`OpenAISwift`** object with the auth token.

```swift
func setup(){
        client  = OpenAISwift(authToken:"PASTE YOUR TOKEN HERE")
    }
```

- **`sendApiRequest(text:)`**: A function that the view calls to send a request to the OpenAI API. It takes a string as a parameter, which represents the user's message. If the string is empty, the function will return nothing. It will also append the user's message to the **`models`** array.

```swift
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
```

- **`send(text:completion:)`**: A private function that sends the **`text`** parameter to the OpenAI API, and calls the completion handler with the response.

```swift
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
```

- **`fetchStringFromWebsite(url:)`**: A function that tries to retrieve a string from a website based on the provided url. It returns the string if successful and returns an error message if not.

```swift
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
```

Whole code: 

```swift
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
        client  = OpenAISwift(authToken:"PASTE YOUR TOKEN HERE")
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
```
