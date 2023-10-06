//___FILEHEADER___

import SwiftUI

// MARK: - View State

protocol ___VARIABLE_sceneName___ModelStatePotocol {
    var text: String { get set }
	var routerEvents: ___VARIABLE_sceneName___Router.RouterEventsType { get }
}

// MARK: - Intent Actions

protocol ___VARIABLE_sceneName___ModelActionsProtocol: AnyObject {
    func dispalyLoading()
    func dispaly(content: Int)
    func dispaly(error: Error)
}

// MARK: - Intent Route

protocol ___VARIABLE_sceneName___ModelRouteProtocol: AnyObject {
	func routeSameScreen()
	func showErrorAlert()
}
