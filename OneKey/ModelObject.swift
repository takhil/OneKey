//
//  ModelObject.swift
//  OneKey
//
//  Created by Tirumalasetty, Akhil on 2/11/17.
//  Copyright © 2017 Tirumalasetty, Akhil. All rights reserved.
//

import Foundation


class ModelObject:NSObject{
    
    var id          :Int
    var displayName :String!
    var userName    :String!
    var password    :String!
    var emailId     :String!
    var hint        :String!
    
    init(id:Int,displayName:String,userName:String,password:String,emailId:String,hint:String){
        
        self.id          = id
        self.displayName = displayName
        self.userName    = userName
        self.password    = password
        self.emailId     = emailId
        self.hint        = hint

    }
}
 
