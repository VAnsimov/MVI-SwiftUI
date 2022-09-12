//
//  ListModelActionsProtocol.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

import UIKit
import SwiftUI
import Combine

// MARK: - View State

protocol ListModelStatePotocol {
    var contentState: ListTypes.Model.ContentState { get }
    var loadingText: String { get }
    var navigationTitle: String { get }

    var routerSubject: ListRouter.Subjects { get }
}

// MARK: - Intent Actions

protocol ListModelActionsProtocol {
    func dispalyLoading()
    func update(contents: [WWDCUrlContent])
    func dispalyError(_ error: Error)
}

// MARK: - Route

protocol ListModelRouterProtocol: AnyObject {
    func routeToVideoPlayer(content: WWDCUrlContent)
}
