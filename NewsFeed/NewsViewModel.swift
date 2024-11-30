//
//  NewsViewModel.swift
//  NewsFeed
//
//  Created by Aleksandr Salagubov on 28.11.2024.
//

import Foundation
import Combine

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
}
