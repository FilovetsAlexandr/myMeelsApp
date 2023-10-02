//
//  DataM.swift
//  myMeelsApp
//
//  Created by Alexandr Filovets on 25.09.23.
//
import UIKit

final class DataM {
    static let shared = DataM()
    var foods: [Food]
    private init() {
        foods = [Food(name: "Картошка", price: 5.0, image: UIImage(named: "Картошка")),
                 Food(name: "Сок", price: 3.0, image: UIImage(named: "Сок")),
                 Food(name: "Бургер", price: 4.0, image: UIImage(named: "Бургер"))]
    }
}
