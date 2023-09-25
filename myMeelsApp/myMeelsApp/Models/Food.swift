//
//  Meal.swift
//  myMeelsApp
//
//  Created by Alexandr Filovets on 25.09.23.
//
import UIKit

struct Food {
    var name: String
    var price: Double
    var image: UIImage?
    
    var ratingArray: [Reviews] = []
    
    var ratingStar: String {
        if let rating = rating {
            return String(repeating: "⭐️", count: Int(rating.rounded(.up)))
        } else {
            return "Нет отзывов"
        }
    }
    
    var rating: Double? {
        if ratingArray.isEmpty {
            return nil
        } else {
            let sum = ratingArray.reduce(0) { $0 + $1.mark }
            return sum / Double(ratingArray.count)
        }
    }
}

struct Reviews {
    private let date = Date()
    
    let text: String
    let mark: Double
    var image: UIImage?
    
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ru_Ru")
        return dateFormatter
    }()
    
    var rating: String {
        return String(repeating: "⭐️", count: Int(mark.rounded(.up)))
    }
    
    var dateStr: String {
        return Reviews.dateFormatter.string(from: date)
    }
}
