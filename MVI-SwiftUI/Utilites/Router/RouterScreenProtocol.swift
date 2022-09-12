//
//  RouterScreenProtocol.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

protocol RouterScreenProtocol: RouterNavigationScreenProtocol & RouterSheetScreenProtocol {
    var routeType: RouterScreenPresentationType { get }
}

enum RouterScreenPresentationType {
    case navigationLink
    case sheet
    case fullScreenCover
}

