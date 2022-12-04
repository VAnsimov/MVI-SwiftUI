//___FILEHEADER___

import SwiftUI

struct ___VARIABLE_sceneName___Router: RouterProtocol {
    typealias RouterScreenType = ScreenType
    typealias RouterAlertType = AlertScreen

    let subjects: Subjects
    var onDismiss: ((RouterScreenType) -> Void)?
}

// MARK: - Navigation Screens

extension ___VARIABLE_sceneName___Router {
    enum ScreenType: RouterScreenProtocol {
        case someScreenOne(text: String)
        case someScreenTwo

        var routeType: RouterScreenPresentationType {
            switch self {
            case .someScreenOne:
                return .sheet

            case .someScreenTwo:
                return .fullScreenCover
            }
        }
    }

    @ViewBuilder
    func makeScreen(type: RouterScreenType) -> some View {
        switch type {
        case let .someScreenOne(text):
            Text(text)

        case .someScreenTwo:
            Text("Some Screen Two")
        }
    }

    func onDismiss(screenType: RouterScreenType) {
        onDismiss?(screenType)
    }
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
