//
//  RouterEvents.swift
//  RouterModifier
//
//  Created by Vyacheslav Ansimov.
//

import Combine

public struct RouterEvents<ScreenType, AlertType>
where ScreenType: RouterScreenProtocol, AlertType: RouterAlertScreenProtocol {

	let screenSubject = PassthroughSubject<ScreenType, Never>()
	let alertSubject = PassthroughSubject<AlertType, Never>()
	let dismissSubject = PassthroughSubject<Void, Never>()
    let oldAlertSubject = PassthroughSubject<AlertType, Never>()
    
    var screenIsEmpty: Bool { screenSubject is PassthroughSubject<RouterEmptyScreen, Never> }

	public init() {}

	public func routeTo(_ type: ScreenType) {
		screenSubject.send(type)
	}

	public func presentAlert(_ type: AlertType) {
        if #available(iOS 15.0, *, macOS 12.0, *) {
            alertSubject.send(type)
        } else {
            oldAlertSubject.send(type)
        }
	}

	public func dismiss() {
		dismissSubject.send()
	}
}
