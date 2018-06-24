//
//  PostPresenter.swift
//  RedditAppChallenge
//
//  Created by Hieu Nguyen on 6/24/18.
//  Copyright © 2018 HMdev. All rights reserved.
//

import Foundation

protocol RedditVC: NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setPosts(posts: JSONReddit)
    func setEmptyPosts()
    
}

class PostPresenter {
    // Our presenter will handle our model and it's modifications to keep the logic away from the view.  The view should know little or nothing about the business logic.
    var json: JSONReddit?
    
    init(){
        self.grabRedditData(by: "new")
    }
    
    // ------------------------------------------------------------------------------------------
    // MARK: - Presenter's control over RedditCollectionViewController's life cycle
    weak private var redditView: RedditVC?
    
    func attachView(view: RedditVC){
        redditView = view
        
    }
    
    func detachView(){
        redditView = nil
    }
    
    // ------------------------------------------------------------------------------------------
    // MARK: - Get ImageData from ImageURL and set doctor object imageData property
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            completion(data, response, error)
            }.resume()
    }
    
    
}

