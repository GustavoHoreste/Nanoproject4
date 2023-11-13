//
//  Array+RestaurantModel.swift
//  NanoProject4
//
//  Created by Fabio Freitas on 13/11/23.
//

import SwiftUI

extension Array where Element == RestaurantModel {
    func getRandomRestaurant() -> RestaurantModel? {
        let randomIdx = Int.random(in: 0...(self.count - 1))
        return self[randomIdx]
    }
}
