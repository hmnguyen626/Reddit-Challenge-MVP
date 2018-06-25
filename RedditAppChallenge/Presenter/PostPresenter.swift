//
//  PostPresenter.swift
//  RedditAppChallenge
//
//  Created by Hieu Nguyen on 6/24/18.
//  Copyright © 2018 HMdev. All rights reserved.
//

import UIKit

protocol RedditVC: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func loadMore()
    
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
        grabRedditData(by: "top")
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
        
        // Empty our collection
        posts = []
        
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
    
    // ------------------------------------------------------------------------------------------
    // Presenter will download the imageData and return Data back to the view
    // MARK: - Download Image Data and send to view
    func downloadImageData(for index: Int, completion: @escaping (UIImage?) -> Void){
        
        guard let url = URL(string: posts[index].thumbnail!) else { return }
        
        // Reddit API returns a thumbnail string, but there are 3 cases: default, self, and an imageurl
        // default: is a gif/video
        // self: is an empty body text, which only has a title or reference to another reddit article
        // imageurl: a link to an imageurl
        // For default and self, I will set the images to a default_image.jpeg, but will retrieve the imagedata for imageurl
        if posts[index].thumbnail == "default" {
            let image = UIImage(named: "default_image.jpeg")
            completion(image)
        }
        else if posts[index].thumbnail == "self" {
            let image = UIImage(named: "default_image.jpeg")
            completion(image)
        }
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            if error != nil {
                print(error!)
            } else {
                if let data = data {
                    
                    let image = UIImage(data: data)
                    completion(image)
                }
            }
        }.resume()
    }

}







