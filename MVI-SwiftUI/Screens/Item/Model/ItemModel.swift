//
//  ItemModel.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI
import Combine
import AVKit

final class ItemModel: ObservableObject, ItemModelStatePotocol {

    @Published var title: String = ""
    @Published var playingText: String = "play"
    @Published var player: AVPlayer = AVPlayer(playerItem: nil)

	let routerEvents = ItemRouter.RouterEventsType()
}

// MARK: - Actions Protocol

extension ItemModel: ItemModelActionsProtocol {

    func setupScreen(url: URL, title: String) {
        self.title = title
        player.replaceCurrentItem(with: AVPlayerItem(url: url))
    }

    func play() {
        player.play()
        changePlaingText(timeControlStatus: player.timeControlStatus)
    }

    func stop() {
        player.pause()
    }
    
    func togglePlaing() {
        switch player.timeControlStatus {
        case .paused:
            player.play()

        case .waitingToPlayAtSpecifiedRate, .playing:
            player.pause()

        @unknown default:
            break
        }
        changePlaingText(timeControlStatus: player.timeControlStatus)
    }
}

// MARK: - Route Protocol

extension ItemModel: ItemModelRouterProtocol {

    func dismissScreen() {
		routerEvents.dismiss()
    }
}

// MARK: - Private

private extension ItemModel {

    func changePlaingText(timeControlStatus: AVPlayer.TimeControlStatus) {
        switch timeControlStatus {
        case .paused:
            playingText = "play"

        case .waitingToPlayAtSpecifiedRate, .playing:
            playingText = "pause"

        @unknown default:
            playingText = ""
        }
    }
}
