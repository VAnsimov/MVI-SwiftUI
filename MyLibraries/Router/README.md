# Router

#### Publication: [medium.com/@vyacheslavansimov/swiftui-and-mvi-3acac8d4416a](https://medium.com/@vyacheslavansimov/swiftui-and-mvi-3acac8d4416a)


## How to use Router?

### Router 

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

### Use Router 

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
