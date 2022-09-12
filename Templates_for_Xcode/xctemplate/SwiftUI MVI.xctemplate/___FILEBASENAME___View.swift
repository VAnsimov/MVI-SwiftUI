//___FILEHEADER___

import SwiftUI

struct ___VARIABLE_sceneName___View: View {

    @StateObject var container: MVIContainer<___VARIABLE_sceneName___IntentProtocol, ___VARIABLE_sceneName___ModelStatePotocol>

    private var intent: ___VARIABLE_sceneName___IntentProtocol { container.intent }
    private var state: ___VARIABLE_sceneName___ModelStatePotocol { container.model }

    var body: some View {
        Text(state.text)
            .modifier(___VARIABLE_sceneName___Router(subjects: state.routerSubject, intent: intent))
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

struct ___VARIABLE_sceneName___View_Previews: PreviewProvider {
    static var previews: some View {
        ___VARIABLE_sceneName___View.build(data: .init())
    }
}
#endif
