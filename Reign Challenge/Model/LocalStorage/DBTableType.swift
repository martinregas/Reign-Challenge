//
//  DBTableType.swift
//  Reign Challenge
//
//  Created by Martin Regas on 21/10/2020.
//

import Foundation

enum DBTableType {
    case post
    case deletedPost
    
    var name:String {
        switch self {
        case .post: return "Post"
        case .deletedPost: return "DeletedPost"
        }
    }
}
