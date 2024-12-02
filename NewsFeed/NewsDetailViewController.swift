//
//  ViewController.swift
//  NewsFeed
//
//  Created by Aleksandr Salagubov on 28.11.2024.
//

import Foundation
import UIKit
import WebKit

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
        
        let moreButton = UIButton(type: .system)
        moreButton.setTitle("Подробнее", for: .normal)
        moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        moreButton.addTarget(self, action: #selector(openFullNews), for: .touchUpInside)
        moreButton.layer.cornerRadius = 12
        moreButton.layer.borderWidth = 1
        moreButton.layer.masksToBounds = false
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, descriptionLabel, moreButton, dateLabel])
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
    
    @objc private func openFullNews() {
        guard let url = URL(string: newsItem.fullUrl) else {
            let alert = UIAlertController(title: "Ошибка", message: "Некорректная ссылка.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ОК", style: .default))
            present(alert, animated: true)
            return
        }
        
        let webVC = WebViewController(url: url)
        navigationController?.pushViewController(webVC, animated: true)
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
