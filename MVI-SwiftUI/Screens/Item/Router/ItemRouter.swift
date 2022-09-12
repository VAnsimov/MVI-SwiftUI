//
//  ItemRouter.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI

struct ItemRouter: RouterProtocol {
    typealias RouterScreenType = ScreenType
    typealias RouterAlertType = AlertScreen

    let subjects: Subjects
    let intent: ItemIntentProtocol

}

// MARK: - Navigation Screens

extension ItemRouter {
    enum ScreenType: RouterScreenProtocol {
        case unowned

        var routeType: RouterScreenPresentationType { .navigationLink }
    }

    @ViewBuilder
    func makeScreen(type: RouterScreenType) -> some View { EmptyView() }
    func onDismiss(screenType: RouterScreenType) {}
}

// MARK: - Alerts

extension ItemRouter {
    enum AlertScreen: RouterAlertScreenProtocol {
        case defaultAlert(title: String, message: String?)
    }

    func makeAlert(type: RouterAlertType) -> Alert {
        switch type {
        case let .defaultAlert(title, message):
            return Alert(title: Text(title),
                         message: message.map { Text($0) },
                         dismissButton: .cancel())
        }
    }
}
