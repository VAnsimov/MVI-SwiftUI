# SwiftUI and MVI

#### Publication: [medium.com/@vyacheslavansimov/swiftui-and-mvi-3acac8d4416a](https://medium.com/@vyacheslavansimov/swiftui-and-mvi-3acac8d4416a)


## MVI — brief history and principle of operation

This pattern was first described by JavaScript developer Andre Staltz. The general principles can be found [here](https://staltz.com/unidirectional-user-interface-architectures.html)

![](README_sources/image_001.jpeg)


- Intent: function from Observable of user events to Observable of “actions”
- Model: function from Observable of actions to Observable of state
- View: function from Observable of state to Observable of rendering
Custom element: subsection of the rendering which is in itself a UI program. May be implemented as MVI, or as a Web Component. Is optional to use in a View.

MVI has a reactive approach. Each module (function) expects some event, and after receiving and processing it, it passes this event to the next module. It turns out an unidirectional flow.

In the mobile app the diagram looks very close to the original with only minor changes:

![](README_sources/image_002.png)

- Intent receives an event from View and communicates with the business logic
- Model receives data from Intent and prepares it for display. The Model also keeps the current state of the View.
- View displays the prepared data.

To provide a unidirectional data flow, you need to make sure that the View has a reference to the Intent, the Intent has a reference to the Model, which in turn has a reference to the View.

The main problem in implementing this approach in SwiftUI is View. View is a structure and Model cannot have references to View. To solve this problem, you can introduce an additional layer Container, which main task is to keep references to Intent and Model, and provide accessibility to the layers so that the unidirectional data flow is truly unidirectional.
It sounds complicated, but it is quite simple in practice.

## MVI

Container is independent of the life cycle of the View because it is @StateObject. Every time the View is reinitialization, Intent and Model remain the same.

![](README_sources/image_003.png)

There is a unidirectional data flow between the modules.

1) View receives the user's event.
2) Intent receives an event from View and communicates with the business logic
3) Model receives data from Intent and prepares it for display. The Model also keeps the current state of the View.
4) View displays the prepared data.

![](README_sources/image_004.png)

# Templates for Xcode

### xctemplate

The template can be found in Templates-for-Xcode/xctemplate

Add the file *.xctemplate to the folder:
/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File Templates

The template can be found in the Xcode menu
File -> New -> File...

### Router

The template can be found in Templates-for-Xcode/xctemplate


# How to use Router?

## Router 

Below is the most complete version, if you don't need something, you don't have to write it.

```swift
struct SomeRouter: RouterProtocol {
     let routerEvents: RouterEvents<ScreenType, AlertType>
}

// MARK: - Screens

extension SomeRouter {
     enum ScreenType: RouterScreenProtocol {
         case videoPlayer
         case group(id: UUID)
     }

	 // Optional
	 // Default is .sheet
     func getRouteType(for type: ScreenType) -> RouterScreenPresentationType {
         switch type {
         case .videoPlayer:
             return .navigationDestination

         case .group:
             return .sheet
         }
     }

	 // Optional
	 // Default is Empty()
     @ViewBuilder
     func makeScreen(for type: ScreenType) -> some View {
         switch type {
         case .videoPlayer:
             Text("VideoPlayer View")

         case let .group(id):
             Text("Group View")
         }
     }

	 // Optional
     func onDismiss(screenType: ScreenType) {}
}

// MARK: - Alerts

extension SomeRouter {

     enum AlertType: RouterAlertScreenProtocol {
         case error(title: String, message: String)
     }

	 // Optional
	 // Default is nil
     func makeTitle(for type: AlertType) -> Text? {
         switch type {
         case let .error(title, _):
             return Text(title)
         }
     }

	 // Optional
	 // Default is Empty()
     func makeMessage(for type: AlertType) -> some View {
         switch type {
         case let .error(_, message):
             return Text(message)
         }
     }

	 // Optional
	 // Default is Empty()
     func makeActions(for type: AlertType) -> some View {
         Text("OK")
     }
 }
```

If you don't need Alerts, you can use `RouterDefaultAlert`

```swift
struct SomeRouter: RouterProtocol {
     let routerEvents: RouterEvents<ScreenType, RouterDefaultAlert>
}

// MARK: - Screens

extension SomeRouter {

     enum ScreenType: RouterScreenProtocol {
         case videoPlayer
         case group(id: UUID)
     }
     
     ...
}
```

If you do not need to go to other screens, then use `RouterEmptyScreen`


```swift
struct SomeRouter: RouterProtocol {
     let routerEvents: RouterEvents<RouterEmptyScreen, AlertType>
}

// MARK: - Alerts

extension SomeRouter {
     enum AlertType: RouterAlertScreenProtocol {
          case error(title: String, message: String)
     }
     
     ...
}
```

## Use Router 

```swift
struct SomeView: View {

    ...

    var body: some View {
        Text("Hello, World!")
            .modifier(SomeRouter(routerEvents: someClass.routerEvents))
    }
}

class SomeClass: ObservableObject {

    let routerEvents = RouterEvents<SomeRouter.ScreenType, SomeRouter.AlertType>()

    func someOperation() {
        routerEvents.routeTo(.group(id: UUID()))
    }
    
	func someError() {
        routerEvents.presentAlert(.error(title: "Error", message: "Something went wrong"))
    }
}
```

## Maintainers

* [Vyacheslav Ansimov](https://www.linkedin.com/in/vansimov/)
