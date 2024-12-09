//
//  NewsViewModel.swift
//  NewsFeed
//
//  Created by Aleksandr Salagubov on 28.11.2024.
//

import Foundation
import Combine
import UIKit

class NewsViewModel {
    @Published var news: [NewsItem] = []
    private var currentPage = 1
    private let baseUrl = "https://webapi.autodoc.ru/api/news/"
    private var cancellables = Set<AnyCancellable>()
    private var isLoading = false
    
    func fetchNews() {
        guard !isLoading else { return }
        isLoading = true
        
        let urlString = "\(baseUrl)\(currentPage)/15"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: APIResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    print("Failed to fetch news: \(error)")
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.news.append(contentsOf: response.news)
                self.currentPage += 1
            })
            .store(in: &cancellables)
    }
    
    func loadImage(for newsItem: NewsItem, completion: @escaping (UIImage?) -> Void) {
        guard let imageUrlString = newsItem.titleImageUrl, let url = URL(string: imageUrlString) else {
            completion(UIImage(named: "placeholder"))
            return
        }
        
        let request = URLRequest(url: url)
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: request),
           let cachedImage = UIImage(data: cachedResponse.data) {
            completion(cachedImage)
        } else {
            URLSession.shared.dataTask(with: url) { data, response, _ in
                guard let data = data, let image = UIImage(data: data), let response = response else {
                    completion(UIImage(named: "placeholder"))
                    return
                }
                
                let cachedResponse = CachedURLResponse(response: response, data: data)
                URLCache.shared.storeCachedResponse(cachedResponse, for: request)
                
                DispatchQueue.main.async {
                    completion(image)
                }
            }.resume()
        }
    }
}
