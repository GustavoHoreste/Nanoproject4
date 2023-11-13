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
        let random = CloudKitManager.shared.restaurantItens.getRandomRestaurant()
        if let restaurant = random {
            return .result(dialog: "Que tal, \(restaurant.name) em \(restaurant.locationRest)?", view: RestaurantIntentPreview(restaurant: restaurant))
        }
        return .result(dialog: "Parece que não há nenhum restaurante cadastrado.")
    }
}
