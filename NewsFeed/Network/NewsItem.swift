//
//  NewsItem.swift
//  NewsFeed
//
//  Created by Aleksandr Salagubov on 28.11.2024.
//

import Foundation

struct APIResponse: Decodable {
    let news: [NewsItem]
    let totalCount: Int
}

struct NewsItem: Decodable {
    let id: Int
    let title: String
    let description: String
    let publishedDate: String
    let fullUrl: String
    let titleImageUrl: String?
}
