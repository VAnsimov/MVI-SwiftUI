//
//  ListView.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI

struct ListView: View {

    @StateObject var container: MVIContainer<ListIntentProtocol, ListModelStatePotocol>

    private var intent: ListIntentProtocol { container.intent }
    private var state: ListModelStatePotocol { container.model }

    var body: some View {
        NavigationView {
            ZStack {
                switch state.contentState {
                case .loading:
					loadingView

                case let .content(urlContents):
					listItemsView(urlContents: urlContents)

                case let .error(text):
					errorView(text: text)
                }
            }
            .onAppear(perform: intent.viewOnAppear)
            .navigationTitle(state.navigationTitle)
            .modifier(ListRouter(routerEvents: state.routerEvents, intent: intent))
        }
    }
}

// MARK: - Views

private extension ListView {

    // Loading View
	var loadingView: some View {
		ZStack {
			Color.white
			Text(state.loadingText)
		}
	}

    // ListItems View
	func listItemsView(urlContents: [ListUrlContentView.StateViewModel]) -> some View {
		ScrollView {
			LazyVStack(spacing: 16) {
				ForEach(urlContents, id: \.self) {
					ListUrlContentView(state: $0, didTap: {
						intent.onTapUrlContent(id: $0)
					})
					.padding(.horizontal)
				}
			}.padding(.vertical)
		}
	}

    // Error View
	func errorView(text: String) -> some View {
		ZStack {
			Color.white
			Text(text)
		}
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
