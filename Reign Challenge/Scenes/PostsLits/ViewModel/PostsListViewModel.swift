//
//  PostViewModel.swift
//  Reign Test
//
//  Created by Martin Regas on 17/10/2020.
//

import UIKit

struct PostsListViewModel {
    
    var requestError : ((String) -> ()) = {_ in}
    
    weak var adapter : GenericAdapter<Post>?
    var service : ServiceProtocol?
    var db: PostsDBProtocol?
        
    init(adapter : GenericAdapter<Post>?,
         service : ServiceProtocol = PostService(),
         db: PostsDBProtocol = PostsDBHelper()) {
        self.adapter = adapter
        self.service = service
        self.db = db
    }
    
    func getTitle() -> String {
        return "REIGN CHALLENGE"
    }
    
    func getPosts() {
        service?.getPosts(completionHandler: { result,error in
            if let posts = result {
                let filteredPosts = self.filterPostsArray(posts: posts)
                self.adapter?.data.value = filteredPosts
                self.savePostsInLocalDB()
            }
            else if let error = error {
                self.getPostsFromLocalDB()
                requestError(HandleConnectionError.handle(error: error))
            }
        })
    }
    
    func savePostsInLocalDB(){
        guard let posts = self.adapter?.data.value else {
            return
        }
        
        self.clearLocalDB()
        
        for post in posts {
            if let id = post.id {
                db?.insert(type: .post, id:id, title: post.title ?? "", author: post.author ?? "", url: post.url ?? "", date: post.date ?? "")
            }
        }
    }
    
    func clearLocalDB() {
        db?.clear(type: .post)
    }
    
    func getPostsFromLocalDB() {
        if let db = db {
            self.adapter?.data.value = db.read(type: .post)
        }
    }
    
    func removeItem(post:Post) {
        if let index = self.adapter?.data.value.firstIndex(of: post) {
            guard let id = post.id else {
                self.adapter?.data.value.remove(at: index)
                return
            }
            
            self.db?.deleteByID(type: .post, id: id)
            self.db?.insert(type: .deletedPost, id: id, title: post.title ?? "", author: post.author ?? "", url: post.url ?? "", date: post.date ?? "")
            
            self.adapter?.data.value.remove(at: index)
        }
    }
    
    func filterPostsArray(posts:[Post]) -> [Post] {
        guard let deletedPosts = self.db?.read(type: .deletedPost) else {
            return posts
        }
        return posts.filter{ !deletedPosts.contains($0) }.filter({$0.id != nil})
    }
}
