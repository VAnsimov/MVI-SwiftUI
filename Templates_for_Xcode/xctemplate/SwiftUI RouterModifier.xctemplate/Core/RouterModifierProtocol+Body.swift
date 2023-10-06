//___FILEHEADER___

import SwiftUI

extension RouterModifierProtocol {

    public func body(content: Content) -> some View {
        content
            .modifier(RouterNavigationDestinationModifier(
                publisher: routerEvents.screenSubject
                    .filter {
                        if #available(iOS 16.0, *, macOS 13.0, *) {
                            return getScreenPresentationType(for: $0) == .navigationDestination
                        } else {
                            return false
                        }
                    }
                    .receive(on: RunLoop.main)
                    .eraseToAnyPublisher(),
                screen: getScreen,
                onDismiss: onScreenDismiss
            ))
            .modifier(RouterNavigationLinkModifier(
                publisher: routerEvents.screenSubject
                    .filter { getScreenPresentationType(for: $0) == .navigationLink }
                    .receive(on: RunLoop.main)
                    .eraseToAnyPublisher(),
                screen: getScreen,
                onDismiss: onScreenDismiss
            ))
            .modifier(RouterDismissModifier(
                publisher: routerEvents.dismissSubject
                    .receive(on: RunLoop.main)
                    .eraseToAnyPublisher()
            ))
            .modifier(RouterSheetModifier(
                isFullScreenCover: false,
                publisher: routerEvents.screenSubject
                    .filter { getScreenPresentationType(for: $0) == .sheet }
                    .receive(on: RunLoop.main)
                    .eraseToAnyPublisher(),
                screen: getScreen,
                onDismiss: onScreenDismiss
            ))
            .modifier(RouterSheetModifier(
                isFullScreenCover: true,
                publisher: routerEvents.screenSubject
                    .filter { getScreenPresentationType(for: $0) == .fullScreenCover }
                    .receive(on: RunLoop.main)
                    .eraseToAnyPublisher(),
                screen: getScreen,
                onDismiss: onScreenDismiss
            ))
            .modifier(RouterAlertModifier(
                publisher: routerEvents.alertSubject
                    .receive(on: RunLoop.main)
                    .eraseToAnyPublisher(),
                title: getAlertTitle,
                message: getAlertMessage,
                actions: getAlertActions,
                oldAlert: getOldAlert
            ))
    }
}

// MARK: - Default values

public extension RouterModifierProtocol {

    func getScreenPresentationType(for type: RouterScreenType) -> RouterScreenPresentationType { .sheet }

    func getScreen(for type: RouterScreenType) -> some View { EmptyView() }

    func onScreenDismiss(type: RouterScreenType) {}

    func getAlertTitle(for type: RouterAlertType) -> Text? {
        guard let type = type as? RouterDefaultAlert else { return nil }

        switch type {
        case let .defaultAlert(title, _, _):
            return title.map { Text($0) }
        }
    }

    func getAlertMessage(for type: RouterAlertType) -> some View {
        (type as? RouterDefaultAlert).map { type in
            switch type {
            case let .defaultAlert(_, message, _):
                return message.map { Text($0) }
            }
        }
    }

    func getAlertActions(for type: RouterAlertType) -> some View {
        (type as? RouterDefaultAlert).map { type in
            switch type {
            case let .defaultAlert(_, _, cancelText):
                return Text(cancelText)
            }
        }
    }

    func getOldAlert(for type: RouterAlertType) -> Alert {
        (type as? RouterDefaultAlert).map { type in
            switch type {
            case let .defaultAlert(title, message, cancelText):
                return Alert (
                    title: Text(title ?? ""),
                    message: message.map { Text($0) },
                    dismissButton: .cancel(Text(cancelText))
                )
            }
        } ?? Alert(title: Text(""))
    }
}
