//___FILEHEADER___

import SwiftUI

struct ___VARIABLE_sceneName___Router: RouterProtocol {
    typealias RouterScreenType = ScreenType
    typealias RouterAlertType = AlertScreen

    let subjects: Subjects
    let intent: ___VARIABLE_sceneName___IntentProtocol
}

// MARK: - Navigation Screens

extension ___VARIABLE_sceneName___Router {
    enum ScreenType: RouterScreenProtocol {
        case unownedOne
        case unownedTwo

        var routeType: RouterScreenPresentationType {
            switch self {
            case .unownedOne, .unownedTwo:
                return .navigationLink
            }
        }
    }

    @ViewBuilder
    func makeScreen(type: RouterScreenType) -> some View {
        switch type {
        case .unownedOne:
            EmptyView()

        case .unownedTwo:
            EmptyView()
        }
    }

    func onDismiss(screenType: RouterScreenType) {}
}

// MARK: - Alerts

extension ___VARIABLE_sceneName___Router {
    enum AlertScreen: RouterAlertScreenProtocol {
        case defaultAlert(title: String, message: String?)
    }

    func makeAlert(type: RouterAlertType) -> Alert {
        switch type {
        case let .defaultAlert(title, message):
            return Alert(title: Text(title),
                         message: message.map { Text($0) },
                         dismissButton: .cancel(Text("Cancel")))
        }
    }
}
