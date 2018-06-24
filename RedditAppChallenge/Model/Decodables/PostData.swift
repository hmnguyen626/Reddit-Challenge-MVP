//
//  Thread.swift
//  RedditChallenge
//
//  Created by Hieu Nguyen on 6/22/18.
//  Copyright © 2018 HMdev. All rights reserved.
//

import UIKit

struct PostData: Decodable {
    let title: String?
    let thumbnail: String?
    var thumbnailImageData: Data?
    
    // subreddit and id is used later to make a request to reddit api to get comments for an article
    // Link - https://www.reddit.com/dev/api/#GET_comments_{article}
    // url example: /r/<subreddit>/comments/<id>.json
    let id: String?
    let subreddit: String?
    
}
