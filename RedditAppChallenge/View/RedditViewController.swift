//
//  ViewController.swift
//  RedditChallenge
//
//  Created by Hieu Nguyen on 6/22/18.
//  Copyright © 2018 HMdev. All rights reserved.
//

import UIKit

class RedditViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    // ------------------------------------------------------------------------------------------
    // Mark: - Initialize our PostPresenter class to handle all the business logic.  Our RedditViewController should have no knowledge of any business logic; it should only be responsible for updating the view with the model presented by the Presenter.
    let presenter = PostPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI Setup
        setup()
        
        // Attach the presenter to give it little control over the life cycle of this current viewcontroller
        presenter.attachView(view: self)
    }
    
    // ------------------------------------------------------------------------------------------
    // MARK: - UICollectionView Datasource Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        
        // Animate our loading
        cell.activityIndicator.startAnimating()
        
        // Set text properties of our cell
        cell.postTitleLabel.text = presenter.posts[indexPath.row].title
        cell.postSubredditNameLabel.text = presenter.posts[indexPath.row].subreddit
        
        presenter.downloadImageData(for: indexPath.row) { (image) in
            DispatchQueue.main.async {
                cell.thumbnailImageView.image = image
                
                // Stop animating our loading
                cell.activityIndicator.stopAnimating()
            }
        }
        
        return cell
    }

    // ------------------------------------------------------------------------------------------
    // MARK: - UICollectionView Delegate methods
    
    // Detect end of collectionview, and promptly load more
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == presenter.posts.count - 1 {
            self.presenter.runApiClientMorePost(with: presenter.after)
            
            print("loading more")
        }
    }
    
    // Set a dynamic size for each of the cell in our CollectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 300)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CommentsViewController()
        vc.subreddit = presenter.posts[indexPath.row].subreddit
        vc.id = presenter.posts[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // ------------------------------------------------------------------------------------------
    // MARK: - Views
    let mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    lazy var hotBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "New", style: .plain, target: self, action: #selector(barButtonAction))
        barButtonItem.tintColor = UIColor.white
        barButtonItem.tag = 1
        
        return barButtonItem
    }()
    
    lazy var randomBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Hot", style: .plain, target: self, action: #selector(barButtonAction))
        barButtonItem.tintColor = UIColor.white
        barButtonItem.tag = 2
        
        return barButtonItem
    }()
    
    // ------------------------------------------------------------------------------------------
    // MARK: - UI Setup
    private func setup(){
        setupMainView()
        setupSubViews()
        setupConstraints()
    }
    
    private func setupMainView(){
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationItem.title = "Home"
        self.navigationItem.rightBarButtonItem = hotBarButton
        self.navigationItem.leftBarButtonItem = randomBarButton
        
        // Register custom cell class
        mainCollectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
        
        // Bg color
        mainCollectionView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 51/255, alpha: 1)
    }
    
    private func setupSubViews(){
        view.addSubview(mainCollectionView)
    }
    
    private func setupConstraints(){
        mainCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    }
    
    // ------------------------------------------------------------------------------------------
    // MARK: - Actions
    @objc func barButtonAction(sender: UIBarButtonItem){
        switch sender.tag {
        case 1:
            presenter.runApiClientNewPost(by: "new")
        case 2:
            presenter.runApiClientNewPost(by: "hot")
        default:
            print("Invalid.")
        }
    }
    
    
    
}

extension RedditViewController: RedditVC {
    
    func startLoading() {
        DispatchQueue.main.async {
            self.mainCollectionView.delegate = nil
            self.mainCollectionView.dataSource = nil
        }
    }
    
    func finishLoading() {
        DispatchQueue.main.async {
            self.mainCollectionView.delegate = self
            self.mainCollectionView.dataSource = self
            self.mainCollectionView.reloadData()
        }
    }
}









