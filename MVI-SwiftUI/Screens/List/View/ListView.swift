//
//  ListView.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI

struct ListView: View {

    @StateObject private var container: MVIContainer<ListIntentProtocol, ListModelStatePotocol>

    private var intent: ListIntentProtocol { container.intent }
    private var properties: ListModelStatePotocol { container.model }

    var body: some View {
        NavigationView {
            bodyView()
                .onAppear(perform: intent.viewOnAppear)
                .overlay(routerView())
                .navigationTitle(properties.navigationTitle)
        }
    }
}

// MARK: - Views

private extension ListView {

    func bodyView() -> some View {
        ZStack {
            switch properties.state {
            case .loading:
                ZStack {
                    Color.white
                    Text(properties.loadingText)
                }

            case let .content(urlContents):
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(urlContents, id: \.self) {
                            ListUrlContentView(state: $0, didTap: {
                                self.intent.onTapUrlContent(id: $0)
                            })
                            .padding(.horizontal)
                        }
                    }.padding(.vertical)
                }

            case let .error(text):
                ZStack {
                    Color.white
                    Text(text)
                }
            }
        }
    }

    func routerView() -> some View {
        ListRouter(routePublisher: properties.routerSubject.eraseToAnyPublisher())
    }
}

// MARK: - Builder

extension ListView {
    
    static func build(data: ListIntent.ExternalData) -> some View {
        let model = ListModel()
        let intent = ListIntent(model: model, externalData: data, urlService: WWDCUrlService())
        let container = MVIContainer(
            intent: intent as ListIntentProtocol,
            model: model as ListModelStatePotocol,
            modelChangePublisher: model.objectWillChange)
        let view = ListView(container: container)
        return view
    }
}

#if DEBUG
// MARK: - Previews

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView.build(data: .init())
    }
}
#endif
