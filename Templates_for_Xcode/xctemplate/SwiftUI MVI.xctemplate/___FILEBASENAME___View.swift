//___FILEHEADER___

import SwiftUI

struct ___VARIABLE_sceneName___View {

    @StateObject var container: MVIContainer<___VARIABLE_sceneName___IntentProtocol, ___VARIABLE_sceneName___ModelStatePotocol>

    private var intent: ___VARIABLE_sceneName___IntentProtocol { container.intent }
    private var state: ___VARIABLE_sceneName___ModelStatePotocol { container.model }

    init(data: ___VARIABLE_sceneName___ExternalData) {
        let model = ___VARIABLE_sceneName___Model()
        let intent = ___VARIABLE_sceneName___Intent(model: model, externalData: data)

        self._container = StateObject(wrappedValue: MVIContainer(
            intent: intent as ___VARIABLE_sceneName___IntentProtocol,
            model: model as ___VARIABLE_sceneName___ModelStatePotocol,
            modelChangePublisher: model.objectWillChange
        ))
    }
}

// MARK: - View

extension ___VARIABLE_sceneName___View: View {

    var body: some View {
        Text(state.text)
            .onAppear(perform: intent.viewOnAppear)
            .onDisappear(perform: intent.viewOnDisappear)
    }
}

#if DEBUG
// MARK: - Previews

#Preview {
    ___VARIABLE_sceneName___View(data: ___VARIABLE_sceneName___ExternalData())
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
