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
    func setPosts(posts: [PostData])
    func setEmptyPosts()
    
}

// Our presenter will handle our model and it's modifications to keep the logic away from the view.  The view should know little or nothing about the business logic.
class PostPresenter {
    
    // Our API layer for Reddit
    //let redditAPIClient = RedditAPI()
    var json: JSONReddit?
    var posts = [PostData]()
    var listCount = 25
    var after = ""
    
    init(){
        grabRedditData(by: "hot")
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
    // Use URLSession to make a request to reddit api with a given subreddit string
    // MARK: - Function that makes a https get request to reddit api
    // Link: https://stackoverflow.com/questions/35357807/running-one-function-after-another-completes
    func grabRedditData(by endpoint: String){
        
        // Reference our view and set delegates = nil, so loaded data can be downloaded before view use data as datasources
        redditView?.startLoading()
        
        guard let url = URL(string: "https://www.reddit.com/r/all/\(endpoint).json") else { return }
        let session = URLSession.shared
        
        session.dataTask(with: url) {
            (data, response, error) in
            
            if error != nil {
                
            } else {
                if let data = data {
                    do {
                        // Decode our data with codable.  See "/Model/Decodables"
                        let json = try JSONDecoder().decode(JSONReddit.self, from: data)
                        
                        // Map our list of posts to an array on non-nil PostData objects
                        self.posts = json.data.children.compactMap{ $0.data }
                        
                        if let after = json.data.after {
                            self.after = after
                        }
                        
                        // Reference our view and set delegates = RedditViewController, to start loading data as datasource
                        self.redditView?.finishLoading()
                        
                    } catch {
                        print("error")
                    }
                }
            }
        }.resume()
    }
    

    
    func downloadImageData(for index: Int, completion: @escaping (Data) -> Void){
        
        guard let url = URL(string: posts[index].thumbnail!) else { return }
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            if error != nil {
                print(error)
            } else {
                if let data = data {
                    completion(data)
                }
            }
        }.resume()
    }

}







