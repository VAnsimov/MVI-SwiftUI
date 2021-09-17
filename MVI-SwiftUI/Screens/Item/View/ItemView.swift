//
//  ItemView.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI
import AVKit

struct ItemView: View {

    @StateObject private var container: MVIContainer<ItemIntent, ItemModel>

    private var intent: ItemIntentProtocol { container.intent }
    private var properties: ItemModelStatePotocol { container.model }

    var body: some View {
        bodyView()
            .onAppear(perform: intent.viewOnAppear)
            .overlay(routerView())
    }
}

// MARK: - Views

private extension ItemView {

    func bodyView() -> some View {
        VStack {
            VideoPlayer(player: properties.player)
                .cornerRadius(8)

            Button {
                self.intent.didTapPlaying()
            } label: {
                Text(properties.playingText)
                    .foregroundColor(.black)
                    .padding()
            }
            
        }
        .padding()
        .navigationBarTitle(properties.title, displayMode: .inline)
    }

    func routerView() -> some View {
        ItemRouter(routePublisher: properties.routerSubject.eraseToAnyPublisher())
    }
}

// MARK: - Builder

extension ItemView {
    static func build(data: ItemIntent.ExternalData) -> some View {
        let model = ItemModel()
        let intent = ItemIntent(model: model, externalData: data)
        let container = MVIContainer(intent: intent, model: model)
        let view = ItemView(container: container)
        return view
    }
}

#if DEBUG
// MARK: - Previews

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        let url: URL! = URL(string: "https://devstreaming-cdn.apple.com/videos/wwdc/2021/10019/6/97B7FCAB-AC78-4A0D-8F28-C5C7AE8C339C/downloads/wwdc2021-10019_hd.mp4?dl=1")
        return ItemView.build(data: .init(title: "Discover concurrency in SwiftUI", url: url))
    }
}
#endif
