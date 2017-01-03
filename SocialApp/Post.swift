//
//  Post.swift
//  SocialApp
//
//  Created by RAMIRO AGUIRRE MELENDEZ on 1/3/17.
//  Copyright © 2017 FABATSA. All rights reserved.
//

import Foundation

class Post {
    fileprivate var _caption: String!
    fileprivate var _imageUrl: String!
    fileprivate var _likes: Int!
    fileprivate var _postKey: String!
    
    var caption: String {
        return _caption
    }
    
    var imageUrl: String {
        return _imageUrl
    }
    
    var likes: Int {
        return _likes
    }
    
    var postKey: String {
        return _postKey
    }
    
    init(caption: String, imageUrl: String, likes: Int){
        self._caption = caption
        self._imageUrl = imageUrl
        self._likes = likes
    }
    
    init(postKey: String, postData: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        if let caption = postData["caption"] as? String{
            self._caption = caption
        }
        
        if let imageUrl = postData["imageUrl"] as? String{
            self._imageUrl = imageUrl
        }
        
        if let likes = postData["likes"] as? Int{
            self._likes = likes
        }
    }
}
