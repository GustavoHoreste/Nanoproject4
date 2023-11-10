//
//  RandomRestaurantIntent.swift
//  NanoProject4
//
//  Created by Fabio Freitas on 09/11/23.
//

import SwiftUI
import AppIntents

struct RandomRestaurantIntent: AppIntent {
    static var title: LocalizedStringResource = "Restaurante Aleatorio"
    func perform() async throws -> some ProvidesDialog & ShowsSnippetView {
        let random = RestaurantViewModel.shared.random
        return .result(dialog: "Que tal, \(random.name) em \(random.locationRest)?", view: RestaurantIntentPreview(restaurant: random))
    }
}
