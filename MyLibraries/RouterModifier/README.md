# Router

#### Publication: [medium.com/@vyacheslavansimov/swiftui-and-mvi-3acac8d4416a](https://medium.com/@vyacheslavansimov/swiftui-and-mvi-3acac8d4416a)


## How to use Router?

### Router 

Below is the most complete version, if you don't need something, you don't have to write it.

Steps:

- We need to implement RouterModifierProtocol is ViewModifier in your router.
- Create a `enum` for the list of screens the View will open to. It should implement the `RouterScreenProtocol` protocol.
- Implement the functions getScreenPresentationType(for:), getScreen(for:), onScreenDismiss(type:) in your router
- Create a `enum` for the list of alerts that the View will display. It should implement the `RouterAlertScreenProtocol` protocol.
- Implement the functions getAlertTitle(for:), getAlertMessage(for:), getAlertActions(for:) in your router


```swift

struct SomeRouter: RouterModifierProtocol {
    let routerEvents: RouterEvents<SomeRouteScreenType, SomeRouterAlertType>
}

// MARK: - Screens

enum SomeRouterScreenType: RouterScreenProtocol {
    case productScreen(id: UUID)
}

extension SomeRouter {

    // Optional
    func getScreenPresentationType(for type: SomeRouterScreenType) -> RouterScreenPresentationType {
        .fullScreenCover
    }

    // Optional
    @ViewBuilder
    func getScreen(for type: SomeRouterScreenType) -> some View {
        switch type {
        case let .productScreen(id):
            Text("Product Screen View: \(id.uuidString)")
        }
    }

    // Optional
    func onScreenDismiss(type: SomeRouterScreenType) {}
}

// MARK: - Alerts

enum SomeRouterAlertType: RouterAlertScreenProtocol {
    case error(title: String, message: String)
}

extension SomeRouter {

    // Optional
    func getAlertTitle(for type: SomeRouterAlertType) -> Text? {
        switch type {
        case let .error(title, _):
            return Text(title)
        }
    }

    // Optional
    @ViewBuilder
    func getAlertMessage(for type: SomeRouterAlertType) -> some View {
        switch type {
        case let .error(_, message):
            Text(message)
        }
    }

    // Optional
    @ViewBuilder
    func getAlertActions(for type: SomeRouterAlertType) -> some View {
        switch type {
        case .error:
            VSTack {
                Button(role: .destructive) {
                    // Handle the deletion.
                } label: { Text("Delete \(details.name)") }
                
                Button("Retry") {
                    // Handle the retry action.
                }
            }
        }
    }
}
```

If you don't need Alerts, you can use `RouterDefaultAlert`

```swift
struct SomeRouter: RouterModifierProtocol {
     let routerEvents: RouterEvents<SomeRouterScreenType, RouterDefaultAlert>
}

// MARK: - Screens

enum SomeRouterScreenType: RouterScreenProtocol {
    case productScreen(id: UUID)
}

extension SomeRouter {
     ...
}
```

If you do not need to go to other screens, then use `RouterEmptyScreen`


```swift
struct SomeRouter: RouterModifierProtocol {
     let routerEvents: RouterEvents<RouterEmptyScreen, SomeRouterAlertType>
}

// MARK: - Alerts

enum SomeRouterAlertType: RouterAlertScreenProtocol {
    case error(title: String, message: String)
}

extension SomeRouter {
     ...
}
```

### Use Router 

```swift
struct SomeView: View {

    let routerEvents = RouterEvents<SomeRouterScreenType, SomeRouterAlertType>()

    var body: some View {
        Text("Hello, World!")
            .modifier(SomeRouter(routerEvents: routerEvents))
            .onAppear {
                routerEvents.routeTo(.group(id: UUID()))
            }
    }
}
```
