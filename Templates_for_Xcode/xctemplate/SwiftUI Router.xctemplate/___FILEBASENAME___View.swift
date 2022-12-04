//___FILEHEADER___

import SwiftUI

struct ___VARIABLE_sceneName___View: View {

    let routerSubject = ___VARIABLE_sceneName___Router.Subjects()

    var body: some View {
        Button(action: {
            routerSubject.screen.send(.someScreenOne(text: "Some Screen"))
        }, label: {
            Text("Hello, World!")
        })
        .modifier(
            ___VARIABLE_sceneName___Router(subjects: routerSubject, onDismiss: { screen in
                // ...
            }))
    }
}

#if DEBUG
// MARK: - Previews

struct ___VARIABLE_sceneName___View_Previews: PreviewProvider {
    static var previews: some View {
        ___VARIABLE_sceneName___View()
    }
}
#endif
