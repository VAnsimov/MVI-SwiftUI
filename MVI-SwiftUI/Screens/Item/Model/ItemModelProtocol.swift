//
//  ItemModelActionsProtocol.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

import Combine
import AVKit

protocol ItemModelStatePotocol {
    var title: String { get }
    var playingText: String { get }
    var player: AVPlayer { get }
    var routerSubject: PassthroughSubject<ItemRouter.ScreenType, Never> { get }
}

protocol ItemModelActionsProtocol {
    func setupScreen(url: URL, title: String)
    func play()
    func togglePlaing()
    func exit()
}
