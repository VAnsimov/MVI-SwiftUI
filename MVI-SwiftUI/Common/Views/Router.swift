//
//  Router.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI
import Combine

struct Router<ScreenType: ScreenKey, Content>: View where Content: View {

    // MARK: Public

    let routePublisher: AnyPublisher<ScreenType, Never>
    let content: (ScreenType?, ActiveService) -> Content

    // MARK: Private

    @ObservedObject private var stateService: StateService
    @State private var screenType: ScreenType? = nil {
        didSet {
            guard !stateService.isSomeTapeActive(),
                  let type = screenType
            else { return }

            stateService.setState(type: type.key, value: true)
        }
    }
    private var active: ActiveService

    // MARK: Life cycle

    init(routePublisher: AnyPublisher<ScreenType, Never>,
                @ViewBuilder content: @escaping (ScreenType?, ActiveService) -> Content) {
        self.routePublisher = routePublisher
        self.content = content
        let stateService = StateService()
        self.stateService = stateService
        self.active = ActiveService(stateService: stateService)
    }

    var body: some View {
        content(screenType, active)
            .onReceive(routePublisher) {
                guard !stateService.isSomeTapeActive() else { return }
                self.screenType = $0
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)

    }
}

// MARK: - Helper classes

protocol ScreenKey {
    var key: String { get }
}

extension Router {
    struct ActiveService {
        private let stateService: StateService

        fileprivate init(stateService: StateService) {
            self.stateService = stateService
        }

        func isActive(key: String) -> Binding<Bool> { stateService.getState(type: key) }
    }
}

private class StateService: ObservableObject {

     @Published private var states: [String: Bool] = [:]
     private var cancellables: Set<AnyCancellable> = []

     func getState(type: String?) -> Binding<Bool> {
         guard let type = type else {
             return Binding<Bool>(get: { false }, set: { _ in })
         }
         let key = type

         if states[key] == nil {
             setState(type: type, value: false)
         }

         let value = states[key] ?? false
         return Binding<Bool>(get: { value }, set: { [weak self] in self?.states[key] = $0 })
     }

     func isSomeTapeActive() -> Bool {
         states.contains(where: { $0.value == true })
     }

     func setState(type: String, value: Bool) {
         let key = type
         states[key] = value
     }
 }
