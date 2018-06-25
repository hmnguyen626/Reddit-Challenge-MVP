//
//  ViewController.swift
//  RedditChallenge
//
//  Created by Hieu Nguyen on 6/22/18.
//  Copyright © 2018 HMdev. All rights reserved.
//

import UIKit

class RedditViewController: UINavigationController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    // ------------------------------------------------------------------------------------------
    // Mark: - Initialize our MainPresenter class
    let presenter = PostPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI Setup
        setup()
        
        presenter.attachView(view: self)
    }
    
    // ------------------------------------------------------------------------------------------
    // MARK: - UICollection methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.listCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        
        cell.postTitleLabel.text = presenter.posts[indexPath.row].title
        cell.postSubredditNameLabel.text = presenter.posts[indexPath.row].subreddit
        
        presenter.downloadImageData(for: indexPath.row) { (data) in
            DispatchQueue.main.async {
                cell.thumbnailImageView.image = UIImage(data: data)
            }
        }
        
        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 300)
        
    }
    
    // ------------------------------------------------------------------------------------------
    // MARK: - Views
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        return indicator
    }()
    
    let mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    // ------------------------------------------------------------------------------------------
    // MARK: - UI Setup
    private func setup(){
        // Register custom cell class
        mainCollectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
        
        // Bg color
        mainCollectionView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 51/255, alpha: 1)
        
        setupSubViews()
        setupConstraints()
    }
    
    private func setupSubViews(){
        view.addSubview(activityIndicator)
        view.addSubview(mainCollectionView)
    }
    
    private func setupConstraints(){
        activityIndicator.heightAnchor.constraint(equalToConstant: 50).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 50).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        mainCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    }
    
}

// Conforming to our PostPresenter protocols
extension RedditViewController: RedditVC {
    
    // By setting our collectionview delegate and datasource to nil, we ensure that our datasource will not attempt to load data until the presenter has data to present to our viewcontroller
    func startLoading() {
        DispatchQueue.main.async {
            self.mainCollectionView.delegate = nil
            self.mainCollectionView.dataSource = nil
            self.activityIndicator.startAnimating()
        }
    }
    
    func finishLoading() {
        DispatchQueue.main.async {
            self.mainCollectionView.delegate = self
            self.mainCollectionView.dataSource = self
            self.activityIndicator.stopAnimating()
        }
    }
    
    func setPosts(posts: [PostData]) {
        print("")
    }
    
    func setEmptyPosts() {
        print("")
    }
}









