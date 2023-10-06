//___FILEHEADER___

import SwiftUI

struct ___VARIABLE_sceneName___Router: RouterModifierProtocol {
	typealias RouterEventsType = RouterEvents<___VARIABLE_sceneName___ScreenType, ___VARIABLE_sceneName___AlertType>

	let routerEvents: RouterEventsType
	let intent: ___VARIABLE_sceneName___IntentProtocol
}

// MARK: - Screens

enum ___VARIABLE_sceneName___ScreenType: RouterScreenProtocol {
	case sameScreen
}

extension ___VARIABLE_sceneName___Router {

	func getScreenPresentationType(for type: ___VARIABLE_sceneName___ScreenType) -> RouterScreenPresentationType {
		switch type {
		case .sameScreen:
			return .navigationLink
		}
	}

	@ViewBuilder
	func getScreen(for type: ___VARIABLE_sceneName___ScreenType) -> some View {
		switch type {
		case .sameScreen:
			Text("Same Screen")
		}
	}

	func onScreenDismiss(type: ___VARIABLE_sceneName___ScreenType) {}
}


// MARK: - Alerts

enum ___VARIABLE_sceneName___AlertType: RouterAlertScreenProtocol {
	case error(title: String, message: String)
}

extension ___VARIABLE_sceneName___Router {

	func getAlertTitle(for type: ___VARIABLE_sceneName___AlertType) -> Text? {
		switch type {
		case let .error(title, _):
			return Text(title)
		}
	}

	func getAlertMessage(for type: ___VARIABLE_sceneName___AlertType) -> some View {
		switch type {
		case let .error(_, message):
			return Text(message)
		}
	}

	func getAlertActions(for type: ___VARIABLE_sceneName___AlertType) -> some View {
		Text("OK")
	}
}
