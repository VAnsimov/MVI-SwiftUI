//___FILEHEADER___

import SwiftUI

final class ___VARIABLE_sceneName___Model: ObservableObject, ___VARIABLE_sceneName___ModelStatePotocol {

    @Published var text: String = ""
}

// MARK: - Actions Protocol

extension ___VARIABLE_sceneName___Model: ___VARIABLE_sceneName___ModelActionsProtocol {

	func displayLoading() {
		text = "loading"
	}

	func display(content: Int) {
		text = "That number is " + String(content)
	}

	func display(error: Error) {
		text = "Error"
	}
}
