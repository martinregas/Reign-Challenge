//
//  PostDetailViewModel.swift
//  Reign Challenge
//
//  Created by Martin Regas on 21/10/2020.
//

import UIKit

struct PostDetailViewModel {
    let post:Post
        
    init(post:Post) {
        self.post = post
    }
    
    func getTitle() -> String {
        return post.title ?? Post.UNTITLED_POST
    }
}
