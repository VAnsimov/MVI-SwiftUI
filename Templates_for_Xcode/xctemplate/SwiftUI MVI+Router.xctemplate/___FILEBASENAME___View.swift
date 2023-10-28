//___FILEHEADER___

import SwiftUI

struct ___VARIABLE_sceneName___View: View {

    @StateObject var container: MVIContainer<___VARIABLE_sceneName___IntentProtocol, ___VARIABLE_sceneName___ModelStatePotocol>

    private var intent: ___VARIABLE_sceneName___IntentProtocol { container.intent }
    private var state: ___VARIABLE_sceneName___ModelStatePotocol { container.model }

    var body: some View {
        Text(state.text)
			.modifier(___VARIABLE_sceneName___Router(routerEvents: state.routerEvents, intent: intent))
            .onAppear(perform: intent.viewOnAppear)
            .onDisappear(perform: intent.viewOnDisappear)
    }

    static func build(data: ___VARIABLE_sceneName___Intent.ExternalData) -> some View {
        let model = ___VARIABLE_sceneName___Model()
        let intent = ___VARIABLE_sceneName___Intent(model: model, externalData: data)
        let container = MVIContainer(
            intent: intent as ___VARIABLE_sceneName___IntentProtocol,
            model: model as ___VARIABLE_sceneName___ModelStatePotocol,
            modelChangePublisher: model.objectWillChange)
        let view = ___VARIABLE_sceneName___View(container: container)
        return view
    }
}

#if DEBUG
// MARK: - Previews

#Preview {
    ___VARIABLE_sceneName___View.build(data: .init())
}
#endif

// MARK: - MVIContainer

import SwiftUI
import Combine

final private class MVIContainer<Intent, Model>: ObservableObject {

	// MARK: Public

	let intent: Intent
	let model: Model

	// MARK: private

	private var cancellable: Set<AnyCancellable> = []

	// MARK: Life cycle

	init(intent: Intent, model: Model, modelChangePublisher: ObjectWillChangePublisher) {
		self.intent = intent
		self.model = model

		modelChangePublisher
			.receive(on: RunLoop.main)
			.sink(receiveValue: objectWillChange.send)
			.store(in: &cancellable)
	}
}
