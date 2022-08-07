//
//  LocoKit_DemoApp.swift
//  LocoKit Demo
//
//  Created by Matt Greenfield on 4/8/22.
//

import SwiftUI

@main
struct LocoKit_DemoApp: App {
    var body: some Scene {
        WindowGroup {
            RootView().environmentObject(Session.highlander)
        }
    }
}
