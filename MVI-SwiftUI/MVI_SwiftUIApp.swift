//
//  MVI_SwiftUIApp.swift
//  MVI-SwiftUI
//
//  Created by Vyacheslav Ansimov.
//

import SwiftUI

@main
struct MVI_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ListView.build(data: .init())
        }
    }
}
