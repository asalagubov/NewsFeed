//
//  NewsViewController.swift
//  NewsFeed
//
//  Created by Aleksandr Salagubov on 30.11.2024.
//

import Foundation
import UIKit


class NewsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private let viewModel = NewsViewModel()
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Новости"
        
        setupCollectionView()
        loadNews()
    }
    
    private func setupCollectionView() {
        
    }
    
    private func loadNews() {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
}
