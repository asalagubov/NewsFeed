//
//  DateUtils.swift
//  NewsFeed
//
//  Created by Aleksandr Salagubov on 30.11.2024.
//


import Foundation

class DateUtils {
    static func formatDate(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateStyle = .long
        outputFormatter.locale = Locale(identifier: "ru_RU")
        
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            return "Unknown Date"
        }
    }
}
