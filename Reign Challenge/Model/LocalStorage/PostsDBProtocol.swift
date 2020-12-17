//
//  PostsDBProtocol.swift
//  Reign Challenge
//
//  Created by Martin Regas on 17/10/2020.
//

import UIKit

protocol PostsDBProtocol {
    func createTable(type:DBTableType)
    func insert(type:DBTableType, id:Int, title:String, author:String, url:String, date:String)
    func read(type:DBTableType) -> [Post]
    func clear(type:DBTableType)
    func deleteByID(type:DBTableType, id:Int)
}
