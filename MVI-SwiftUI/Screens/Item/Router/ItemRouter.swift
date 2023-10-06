//
//  ItemRouter.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI
import RouterModifier

struct ItemRouter: RouterModifierProtocol {
	typealias RouterEventsType = RouterEvents<RouterEmptyScreen, RouterDefaultAlert>

	let routerEvents: RouterEventsType
    let intent: ItemIntentProtocol
}
