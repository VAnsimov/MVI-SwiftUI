//___FILEHEADER___

import SwiftUI

// MARK: - View State

protocol ___VARIABLE_sceneName___ModelStatePotocol {
	var text: String { get set }
	var routerSubject: __VARIABLE_sceneName___Router.RouterEventsType { get }
}

// MARK: - Intent Actions

protocol ___VARIABLE_sceneName___ModelActionsProtocol: AnyObject {
	func dispalyLoading()
	func dispaly(content: Int)
	func dispaly(error: Error)
}

// MARK: - Route

protocol ___VARIABLE_sceneName___ModelRouterProtocol: AnyObject {
	func routeToAlert()
	func closeScreen()
}
