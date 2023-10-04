//
//  RouterProtocol.swift
//  Router
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI

///```swift
/// struct SomeRouter: RouterProtocol {
///
///     enum ScreenType: RouterScreenProtocol {
///         case videoPlayer
///         case group(id: UUID)
///     }
///
///     let routerEvents: RouterEvents<ScreenType, RouterDefaultAlert>
///
///     // MARK: - Screens
///
///     func getRouteType(for type: ScreenType) -> RouterScreenPresentationType {
///         switch type {
///         case .videoPlayer:
///             return .navigationDestination
///
///         case .group:
///             return .sheet
///         }
///     }
///
///     @ViewBuilder
///     func makeScreen(for type: ScreenType) -> some View {
///         switch type {
///         case .videoPlayer:
///             Text("VideoPlayer View")
///
///         case let .group(id):
///             Text("Group View")
///         }
///     }
///
///     func onDismiss(screenType: ScreenType) {}
///
///     // MARK: - Alerts
///
///     enum AlertType: RouterAlertScreenProtocol {
///         case error(title: String, message: String)
///     }
///
///     func makeTitle(for type: AlertType) -> Text? {
///         switch type {
///         case let .error(title, _):
///             return Text(title)
///         }
///     }
///
///     func makeMessage(for type: AlertType) -> some View {
///         switch type {
///         case let .error(_, message):
///             return Text(message)
///         }
///     }
///
///     func makeActions(for type: AlertType) -> some View {
///         Text("OK")
///     }
/// }
///
/// ```
///
/// ```swift
/// struct SomeView: View {
///
///     ...
///
///     var body: some View {
///         Text("Hello, World!")
///             .modifier(SomeRouter(routerEvents: someClass.routerEvents))
///     }
/// }
/// ```
///
/// ```swift
/// class SomeClass: ObservableObject {
///     let routerEvents = RouterEvents<SomeRouter.ScreenType, RouterDefaultAlert>()
///
///     func someOperation() {
///         routerEvents.routeTo(.group(id: UUID()))
///     }
/// }
/// ```
public protocol RouterProtocol: ViewModifier {
	associatedtype RouterScreenType: RouterScreenProtocol
	associatedtype RouterAlertType: RouterAlertScreenProtocol

    associatedtype RouterScreenView: View
	associatedtype AlertMessageView: View
	associatedtype AlertActionsView: View

    var routerEvents: RouterEvents<RouterScreenType, RouterAlertType> { get }

	// MARK: Screens

	func getRouteType(for type: RouterScreenType) -> RouterScreenPresentationType
    func makeScreen(for type: RouterScreenType) -> RouterScreenView
	func onDismiss(screenType: RouterScreenType)

	// MARK: Alerts

	@available(iOS 15.0, *)
	func makeTitle(for type: RouterAlertType) -> Text?

	@available(iOS 15.0, *)
	func makeMessage(for type: RouterAlertType) -> AlertMessageView

	@available(iOS 15.0, *)
	func makeActions(for type: RouterAlertType) -> AlertActionsView

	func makeOldAlert(for type: RouterAlertType) -> Alert
}

// MARK: - Body

extension RouterProtocol {

	public func body(content: Content) -> some View {
		content
			.modifier(RouterNavigationLinkModifier(
				publisher: routerEvents.screenSubject.filter {
					getRouteType(for: $0) == .navigationLink
				}.eraseToAnyPublisher(),
				screen: makeScreen,
				onDismiss: onDismiss
			))
			.modifier(RouterNavigationDestinationModifier(
				publisher: routerEvents.screenSubject.filter {
					getRouteType(for: $0) == .navigationDestination
				}.eraseToAnyPublisher(),
				screen: makeScreen,
				onDismiss: onDismiss
			))
			.modifier(RouterDismissModifier(
				publisher: routerEvents.dismissSubject.eraseToAnyPublisher()
			))
			.modifier(RouterSheetModifier(
				isFullScreenCover: false,
				publisher: routerEvents.screenSubject.filter {
					getRouteType(for: $0) == .sheet
				}.eraseToAnyPublisher(),
				screen: makeScreen,
				onDismiss: onDismiss
			))
			.modifier(RouterSheetModifier(
				isFullScreenCover: true,
				publisher: routerEvents.screenSubject.filter {
					getRouteType(for: $0) == .fullScreenCover
				}.eraseToAnyPublisher(),
				screen: makeScreen,
				onDismiss: onDismiss
			))
			.modifier(RouterAlertModifier(
				publisher: routerEvents.alertSubject.eraseToAnyPublisher(),
				title: makeTitle,
				message: makeMessage,
				actions: makeActions, 
				oldAlert: makeOldAlert
			))
	}
}

// MARK: - Default values

public extension RouterProtocol {

	func getRouteType(for type: RouterScreenType) -> RouterScreenPresentationType { .sheet }

	func makeScreen(for type: RouterScreenType) -> some View { EmptyView() }
	
	func onDismiss(screenType: RouterScreenType) {}

	func makeTitle(for type: RouterAlertType) -> Text? {
		guard let type = type as? RouterDefaultAlert else { return nil }

		switch type {
		case let .defaultAlert(title, _, _):
			return title.map { Text($0) }
		}
	}

	func makeMessage(for type: RouterAlertType) -> some View {
		(type as? RouterDefaultAlert).map { type in
			switch type {
			case let .defaultAlert(_, message, _):
				return message.map { Text($0) }
			}
		}
	}

	func makeActions(for type: RouterAlertType) -> some View {
		(type as? RouterDefaultAlert).map { type in
			switch type {
			case let .defaultAlert(_, _, cancelText):
				return Text(cancelText)
			}
		}
	}

	func makeOldAlert(for type: RouterAlertType) -> Alert {
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
