//___FILEHEADER___

import SwiftUI
import Router

struct ___VARIABLE_sceneName___Router: RouterProtocol {
	// typealias RouterEventsType = RouterEvents<RouterEmptyScreen, RouterDefaultAlert>
	typealias RouterEventsType = RouterEvents<ScreenType, AlertType>

	let routerEvents: RouterEventsType
	let intent: ___VARIABLE_sceneName___IntentProtocol
}

// MARK: - Screens

extension ___VARIABLE_sceneName___Router {

	enum ScreenType: RouterScreenProtocol {
		case unownedOne
		case unownedTwo
	}

	func getRouteType(for type: ScreenType) -> RouterScreenPresentationType {
		switch type {
		case unownedOne:
			return .sheet

		case unownedTwo:
			return .navigationDestination
		}
	}

	@ViewBuilder
	func makeScreen(for type: ScreenType) -> some View {
		switch type {
		case unownedOne:
			return Text("Screen One")

		case unownedTwo:
			return Text("Screen Two")
		}
	}

	func onDismiss(screenType: ScreenType) {}
}

// MARK: - Alerts

extension ___VARIABLE_sceneName___Router {

	 enum AlertType: RouterAlertScreenProtocol {
		 case error(title: String, message: String)
	 }

	 func makeTitle(for type: AlertType) -> Text? {
		 switch type {
		 case let .error(title, _):
			 return Text(title)
		 }
	 }

	 func makeMessage(for type: AlertType) -> some View {
		 switch type {
		 case let .error(_, message):
			 return Text(message)
		 }
	 }

	 func makeActions(for type: AlertType) -> some View {
		 Text("OK")
	 }
 }
