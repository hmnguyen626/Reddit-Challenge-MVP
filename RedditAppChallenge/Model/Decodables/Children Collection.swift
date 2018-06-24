//
//  PostCollection.swift
//  RedditChallenge
//
//  Created by Hieu Nguyen on 6/22/18.
//  Copyright © 2018 HMdev. All rights reserved.
//

import Foundation

struct ChildrenCollection: Decodable {
    
    var children: [Child]
    let after: String?
    
}


