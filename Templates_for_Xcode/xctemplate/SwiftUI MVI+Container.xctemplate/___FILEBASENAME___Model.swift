//___FILEHEADER___

import SwiftUI

final class ___VARIABLE_sceneName___Model: ObservableObject, ___VARIABLE_sceneName___ModelStatePotocol {

    @Published var text: String = ""
    let routerSubject = ___VARIABLE_sceneName___Router.Subjects()
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
        routerSubject.alert.send(.defaultAlert(title: "Error", message: "Something went wrong"))
    }

    func closeScreen() {
        routerSubject.close.send(())
    }
}



