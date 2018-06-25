//
//  APIClient.swift
//  RedditAppChallenge
//
//  Created by Hieu Nguyen on 6/25/18.
//  Copyright © 2018 HMdev. All rights reserved.
//

import Foundation

class APIClientService {
    
    // Function that makes an API request to reddit api
    // route: /r/all/<endpoint>.json
    func makeThreadRequest(url: URL, completion: @escaping ([PostData], String) -> Void ){
        
        let session = URLSession.shared
        
        session.dataTask(with: url) {
            (data, response, error) in
            
            if error != nil {
                print("Error fetching data")
            } else {
                if let data = data {
                    do {
                        // Decode our data with codable.  See "/Model/Decodables"
                        let json = try JSONDecoder().decode(JSONReddit.self, from: data)
                        
                        // Map our list of posts to an array on non-nil PostData objects
                        let posts = json.data.children.compactMap{ $0.data }
                        
                        if let after = json.data.after {
                            let afterTag = after
                            
                            completion(posts, afterTag)
                        }
                        
                    } catch {
                        print("error")
                    }
                }
            }
            }.resume()
        
    }
    
    // Function that makes an API request to reddit api
    // route: /r/<subreddit>/comments/<id>.json
    func makeCommentRequest(url: URL, completion: @escaping ([CommentData]) -> Void ){
        
        let session = URLSession.shared
        
        session.dataTask(with: url) {
            (data, response, error) in
            
            if error != nil {
                print("Error fetching data")
            } else {
                if let data = data {
                    do {
                        
                        // Decoding JSON that are top-level arrays, use .decode([].self, from:)
                        let json = try JSONDecoder().decode([JSONComment].self, from: data)
                        
                        // Map our list of posts to an array on non-nil PostData objects
                        let comments = json[1].data.children.compactMap{ $0.data }
                        
                        completion(comments)
                        
                    } catch {
                        print("error getting json")
                    }
                }
            }
            }.resume()
        
    }
    
    
}
