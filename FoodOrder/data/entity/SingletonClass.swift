//
//  SingletonClass.swift
//  FoodOrder
//
//  Created by Reyhan Nur Ünlü on 16.01.2025.
//

import Foundation
import RxSwift
import RxCocoa


class CartManager {
    static let shared = CartManager() // Singleton instance

    // Yemek adedini saklayan BehaviorRelay
    let selectedQuantity = BehaviorRelay<Int>(value: 0)
}
