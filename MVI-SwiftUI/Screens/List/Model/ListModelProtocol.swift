//
//  ListModelActionsProtocol.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

import UIKit
import SwiftUI
import Combine

protocol ListModelStatePotocol {
    var state: ListModel.ScreenState { get }
    var loadingText: String { get }
    var navigationTitle: String { get }
    var routerSubject: PassthroughSubject<ListRouter.ScreenType, Never> { get }
}

protocol ListModelActionsProtocol: AnyObject {
    func dispalyLoading()
    func update(contents: [WWDCUrlContent])
    func dispalyError(_ error: Error)
    func routeToVideoPlayer(content: WWDCUrlContent)
}
