//
//  ItemRouter.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI
import Router

struct ItemRouter: RouterProtocol {
	typealias RouterEventsType = RouterEvents<RouterEmptyScreen, RouterDefaultAlert>

	let routerEvents: RouterEventsType
    let intent: ItemIntentProtocol
}
