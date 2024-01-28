//
//  RouterModifierProtocol+Body.swift
//  RouterModifier
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI

extension RouterModifierProtocol {

    public func body(content: Content) -> some View {
        content
            .modifier(navigationDestinationModifier)
            .modifier(navigationLinkModifier)
            .modifier(sheetModifier)
            .modifier(fullScreenCoverModifier)
            .modifier(alertModifier)
            .modifier(dismissModifier)
    }
}

// MARK: - Modifiers

private extension RouterModifierProtocol {

    var navigationDestinationModifier: some ViewModifier {
        ConditionalModifier(
            isEmpty: routerEvents.screenIsEmpty,
            viewModifier: {
                RouterNavigationDestinationModifier(
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
                )
            })
    }

    var navigationLinkModifier: some ViewModifier {
        ConditionalModifier(
            isEmpty: routerEvents.screenIsEmpty,
            viewModifier: {
                RouterNavigationLinkModifier(
                    publisher: routerEvents.screenSubject
                        .filter { getScreenPresentationType(for: $0) == .navigationLink }
                        .receive(on: RunLoop.main)
                        .eraseToAnyPublisher(),
                    screen: getScreen,
                    onDismiss: onScreenDismiss
                )
            })
    }

    var sheetModifier: some ViewModifier {
        ConditionalModifier(
            isEmpty: routerEvents.screenIsEmpty,
            viewModifier: {
                RouterSheetModifier(
                    isFullScreenCover: false,
                    publisher: routerEvents.screenSubject
                        .filter { getScreenPresentationType(for: $0) == .sheet }
                        .receive(on: RunLoop.main)
                        .eraseToAnyPublisher(),
                    screen: getScreen,
                    onDismiss: onScreenDismiss
                )
            })
    }

    var fullScreenCoverModifier: some ViewModifier {
        ConditionalModifier(
            isEmpty: routerEvents.screenIsEmpty,
            viewModifier: {
                RouterSheetModifier(
                    isFullScreenCover: true,
                    publisher: routerEvents.screenSubject
                        .filter { getScreenPresentationType(for: $0) == .fullScreenCover }
                        .receive(on: RunLoop.main)
                        .eraseToAnyPublisher(),
                    screen: getScreen,
                    onDismiss: onScreenDismiss
                )
            })
    }

    var alertModifier: some ViewModifier {
        RouterAlertModifier(
            publisher: routerEvents.alertSubject
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher(),
            title: getAlertTitle,
            message: getAlertMessage,
            actions: getAlertActions
        )
    }

    var dismissModifier: some ViewModifier {
        RouterDismissModifier(
            publisher: routerEvents.dismissSubject
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        )
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
                return Button(role: .cancel, action: {}, label: { Text(cancelText) })
			}
		}
	}
}

// MARK: - Helper classes

private struct ConditionalModifier<Modifier>: ViewModifier where Modifier: ViewModifier {

    var isEmpty: Bool
    var viewModifier: () -> Modifier

    func body(content: Content) -> some View {
        if isEmpty {
            content.modifier(EmptyModifier())
        } else {
            content.modifier(viewModifier())
        }
    }
}
