//
//  RouterScreenProtocol.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

protocol RouterScreenProtocol: RouterNavigationViewScreenProtocol & RouterNavigationStackScreenProtocol & RouterSheetScreenProtocol {
    var routeType: RouterScreenPresentationType { get }
}

enum RouterScreenPresentationType {
    case sheet
    case fullScreenCover
    case navigationLink

    // To make it work, you have to use NavigationStack
    case navigationDestination
}

