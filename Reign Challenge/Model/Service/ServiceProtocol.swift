//
//  PostService.swift
//  Reign Challenge
//
//  Created by Martin Regas on 14/10/2020.
//

import Foundation

protocol ServiceProtocol {
    func getPosts(completionHandler: @escaping ([Post]?, URLError?) -> ())
}
