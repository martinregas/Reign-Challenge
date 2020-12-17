//
//  PostsDataStore.swift
//  Reign Test
//
//  Created by Martin Regas on 16/10/2020.
//

import UIKit

struct PostsDataStore{
    var posts: [Post]
}

extension PostsDataStore:Decodable {
    private enum CodingKeys: String, CodingKey {
        case hits = "hits"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        posts = try container.decode([Post].self, forKey: .hits)
        print(posts)
    }
}
