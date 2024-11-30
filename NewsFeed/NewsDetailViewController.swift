//
//  ViewController.swift
//  NewsFeed
//
//  Created by Aleksandr Salagubov on 28.11.2024.
//

import UIKit

class NewsDetailViewController: UIViewController {
    private let newsItem: NewsItem
    
    init(newsItem: NewsItem) {
        self.newsItem = newsItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupAppearance()
    }
    
    func setupAppearance() {
       
    }
    
}

