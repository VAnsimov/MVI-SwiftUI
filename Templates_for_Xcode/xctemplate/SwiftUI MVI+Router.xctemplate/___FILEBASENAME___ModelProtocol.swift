//___FILEHEADER___

import SwiftUI

// MARK: - View State

protocol ___VARIABLE_sceneName___ModelStatePotocol {
    var text: String { get set }
	var routerEvents: ___VARIABLE_sceneName___Router.RouterEventsType { get }
}

// MARK: - Intent Actions

protocol ___VARIABLE_sceneName___ModelActionsProtocol: AnyObject {
    func displayLoading()
    func display(content: Int)
    func display(error: Error)

    func routeTo(screen: ___VARIABLE_sceneName___ScreenType)
    func show(alert: ___VARIABLE_sceneName___AlertType)
}
