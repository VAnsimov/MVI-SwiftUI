//___FILEHEADER___

import SwiftUI

final class ___VARIABLE_sceneName___Model: ObservableObject, ___VARIABLE_sceneName___ModelStatePotocol {

	@Published var text: String = ""

	let routerEvents = ___VARIABLE_sceneName___Router.RouterEventsType()
}

// MARK: - Actions Protocol

extension ___VARIABLE_sceneName___Model: ___VARIABLE_sceneName___ModelActionsProtocol {

	func dispalyLoading() {
		text = "loading"
	}

	func dispaly(content: Int) {
		text = "That number is " + String(content)
	}

	func dispaly(error: Error) {
		text = "Error"
	}
}

// MARK: - Route Protocol

extension ___VARIABLE_sceneName___Model: ___VARIABLE_sceneName___ModelRouterProtocol {

	func routeToAlert() {
		routerEvents.presentAlert(.defaultAlert(title: "Error", message: "Something went wrong", cancelText: "OK"))
	}

	func closeScreen() {
		routerEvents.dismiss()
	}
}



