//
//  ViewController.swift
//  NewsFeed
//
//  Created by Aleksandr Salagubov on 28.11.2024.
//

import Foundation
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
    
    private func setupAppearance() {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.text = newsItem.title
        titleLabel.numberOfLines = 0
        
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.text = newsItem.description
        descriptionLabel.numberOfLines = 0
        
        let dateLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        dateLabel.textColor = .gray
        dateLabel.text = DateUtils.formatDate(newsItem.publishedDate)
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        if let imageUrlString = newsItem.titleImageUrl, let url = URL(string: imageUrlString) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                } else {
                    imageView.image = UIImage(named: "placeholder")
                }
            }.resume()
        } else {
            imageView.image = UIImage(named: "placeholder")
        }
        
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, descriptionLabel, dateLabel])
        stackView.axis = .vertical
        stackView.spacing = 16
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 200),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6)
        ])
    }
    
}
