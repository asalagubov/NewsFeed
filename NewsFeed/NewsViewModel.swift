//
//  NewsViewModel.swift
//  NewsFeed
//
//  Created by Aleksandr Salagubov on 28.11.2024.
//

import Foundation

class NewsViewModel {
    var news: [NewsItem] = []
    private let baseUrl = "https://webapi.autodoc.ru/api/news/"
    
    func fetchNews(completion: @escaping () -> Void) {
        
    }
}
