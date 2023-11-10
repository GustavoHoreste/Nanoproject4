//
//  IntentsShortcutProvider.swift
//  NanoProject4
//
//  Created by Fabio Freitas on 09/11/23.
//

import SwiftUI
import AppIntents

struct IntentsShortcutProvider: AppShortcutsProvider {
    @AppShortcutsBuilder
    static var appShortcuts: [AppShortcut] {
        AppShortcut(intent: RandomRestaurantIntent(), phrases: ["Teste de \(.applicationName)"], shortTitle: "Restaurante Aleatório", systemImageName: "rectangle.fill.on.rectangle.angled.fill")
    }
}
