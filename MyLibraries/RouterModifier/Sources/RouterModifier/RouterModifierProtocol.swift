//
//  RouterModifierProtocol.swift
//  RouterModifier
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI

/// RouterModifierProtocol
///
/// Below is the most complete version, if you don't need something, you don't have to write it.
///
/// Steps:
///
/// - We need to implement RouterModifierProtocol is ViewModifier in your router.
/// - Create a `enum` for the list of screens the View will open to. It should implement the `RouterScreenProtocol` protocol.
/// - Implement the functions getScreenPresentationType(for:), getScreen(for:), onScreenDismiss(type:) in your router
/// - Create a `enum` for the list of alerts that the View will display. It should implement the `RouterAlertScreenProtocol` protocol.
/// - Implement the functions getAlertTitle(for:), getAlertMessage(for:), getAlertActions(for:) in your router
///
/// ```swift
/// struct SomeRouter: RouterModifierProtocol {
///
///     // If you don't need Alerts, you can use `RouterDefaultAlert`. Example: RouterEvents<SomeRouterScreenType, RouterDefaultAlert>
///     // If you do not need to go to other screens, then use `RouterEmptyScreen`. Example: RouterEvents<RouterEmptyScreen, SomeRouterAlertType>
///     let routerEvents: RouterEvents<SomeRouteScreenType, SomeRouterAlertType>
/// }
///
/// // MARK: - Screens
///
/// enum SomeRouterScreenType: RouterScreenProtocol {
///     case productScreen(id: UUID)
/// }
///
/// extension SomeRouter {
///
///     // Optional
///     func getScreenPresentationType(for type: SomeRouterScreenType) -> RouterScreenPresentationType {
///         .fullScreenCover
///     }
///
///     // Optional
///     @ViewBuilder
///     func getScreen(for type: SomeRouterScreenType) -> some View {
///         switch type {
///         case let .productScreen(id):
///             Text("Product Screen View: \(id.uuidString)")
///         }
///     }
///
///	    // Optional
///     func onScreenDismiss(type: SomeRouterScreenType) {}
/// }
///
/// // MARK: - Alerts
///
/// enum SomeRouterAlertType: RouterAlertScreenProtocol {
///     case error(title: String, message: String)
/// }
///
/// extension SomeRouter {
///
///     // Optional
///     func getAlertTitle(for type: SomeRouterAlertType) -> Text? {
///         switch type {
///         case let .error(title, _):
///             Text(title)
///         }
///     }
///
///     // Optional
///     @ViewBuilder
///     func geteAlertMessage(for type: SomeRouterAlertType) -> some View {
///         switch type {
///         case let .error(_, message):
///             Text(message)
///         }
///     }
///
///     // Optional
///     @ViewBuilder
///     func getAlertActions(for type: SomeRouterAlertType) -> some View {
///         Text("OK")
///     }
/// }
/// ```
///
/// Use Router
///
/// ```swift
/// struct SomeView: View {
///
///     let routerEvents = RouterEvents<SomeRouterScreenType, SomeRouterAlertType>()
///
///     var body: some View {
///         Text("Hello, World!")
///             .modifier(SomeRouter(routerEvents: routerEvents))
///             .onAppear {
///                 routerEvents.routeTo(.group(id: UUID()))
///             }
///     }
/// }
/// ```
public protocol RouterModifierProtocol: ViewModifier {
	associatedtype RouterScreenType: RouterScreenProtocol
	associatedtype RouterAlertType: RouterAlertScreenProtocol

    associatedtype RouterScreenView: View
	associatedtype AlertMessageView: View
	associatedtype AlertActionsView: View

    var routerEvents: RouterEvents<RouterScreenType, RouterAlertType> { get }

	// MARK: Screens

	func getScreen(for type: RouterScreenType) -> RouterScreenView
	func getScreenPresentationType(for type: RouterScreenType) -> RouterScreenPresentationType
	func onScreenDismiss(type: RouterScreenType)

	// MARK: Alerts

	func getAlertTitle(for type: RouterAlertType) -> Text?
	func getAlertMessage(for type: RouterAlertType) -> AlertMessageView
	func getAlertActions(for type: RouterAlertType) -> AlertActionsView
}
