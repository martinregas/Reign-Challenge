//
//  Post.swift
//  Reign Test
//
//  Created by Martin Regas on 14/10/2020.
//

import UIKit

extension Post {
    static let UNTITLED_POST = "Untitled"
    static let ANONYMOUS_POST = "Anonymous"
}

struct Post {
    var id:Int?
    var title:String?
    var author:String?
    var url:String?
    var date:String?

    init(id:Int?, title: String?, author: String?, url: String?, date:String) {
        self.id = id
        self.title = title
        self.author = author
        self.url = url
        self.date = date
    }
}

extension Post: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id = "story_id"
        case author = "author"
        case title = "story_title"
        case url = "story_url"
        case date = "created_at"
        case highlightResult = "_highlightResult"
        case value = "value"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let highlightResult = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .highlightResult)
        
        if let author = try? highlightResult.nestedContainer(keyedBy: CodingKeys.self, forKey: .author) {
            self.author = try author.decodeIfPresent(String.self, forKey: .value) ?? ""
        }

        if let title = try? highlightResult.nestedContainer(keyedBy: CodingKeys.self, forKey: .title) {
            self.title = try title.decodeIfPresent(String.self, forKey: .value) ?? ""
        }
        
        if let url = try? highlightResult.nestedContainer(keyedBy: CodingKeys.self, forKey: .url) {
            self.url = try url.decodeIfPresent(String.self, forKey: .value) ?? ""
        }
        
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.date = try container.decodeIfPresent(String.self, forKey: .date)
    }
}

extension Post: Equatable {
    static func ==(lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id && lhs.date == rhs.date && lhs.author == rhs.author && lhs.title == rhs.title
    }
}

