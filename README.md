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
