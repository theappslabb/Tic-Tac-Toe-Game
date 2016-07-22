//
//  BaseObject.swift
//  Tic Tac Toe
//
//  Created by Gurjit Singh Ghangura on 2016-07-21.
//  Copyright © 2016 Gurjit Singh Ghangura. All rights reserved.
//

import UIKit

class BaseObject: NSObject {
    //1
    class var sharedInstance: BaseObject {
        struct Singleton {
            static let instance = BaseObject()
        }
        return Singleton.instance
    }
    var isComputerPlaying : Bool!
    var userName : String!
}
