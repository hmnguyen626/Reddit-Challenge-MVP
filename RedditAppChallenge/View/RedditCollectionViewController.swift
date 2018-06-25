//
//  ViewController.swift
//  RedditChallenge
//
//  Created by Hieu Nguyen on 6/22/18.
//  Copyright © 2018 HMdev. All rights reserved.
//

import UIKit

class RedditViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    // ------------------------------------------------------------------------------------------
    // Mark: - Initialize our MainPresenter class
    let presenter = PostPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI Setup
        setup()
        
        presenter.attachView(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.preparePosts()
    }
    
    // ------------------------------------------------------------------------------------------
    // MARK: - UICollection methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Use presenter in future to return list size here
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        
        cell.postTitleLabel.text = presenter.posts[indexPath.row].title
        cell.postSubredditNameLabel.text = presenter.posts[indexPath.row].subreddit
        
        return cell
    }
    // ------------------------------------------------------------------------------------------
    // MARK: - Views
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        return indicator
    }()
    
    // ------------------------------------------------------------------------------------------
    // MARK: - UI Setup
    private func setup(){
        // Register custom cell class
        collectionView?.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
        
        // Bg color
        collectionView?.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 51/255, alpha: 1)
        
        setupSubViews()
        setupConstraints()
    }
    
    private func setupSubViews(){
        view.addSubview(activityIndicator)
    }
    
    private func setupConstraints(){
        activityIndicator.heightAnchor.constraint(equalToConstant: 50).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 50).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}

extension RedditViewController: RedditVC {
    func startLoading() {
        activityIndicator.startAnimating()
    }

    func finishLoading() {
        activityIndicator.stopAnimating()
    }

    func setPosts(posts: [PostData]) {
        print("")
    }

    func setEmptyPosts() {
        print("")
    }
}

extension RedditViewController {
    
    // Set our collectionview cell's width to our windowframe and a height of 300
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 300)
    }
    
}







