//
//  BSONObjectId.swift
//  BSONObjectId
//
//  Created by Petr Pavlik on 2016-03-15.
//  Copyright © 2016 PerfectlySoft. All rights reserved.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import libmongoc

public class BSONObjectId {
    
    let oid: UnsafePointer<bson_oid_t>
    
    init(oid: UnsafePointer<bson_oid_t>) {
        self.oid = oid
    }
    
    public var hashValue: Int {
        return Int(bson_oid_hash(oid))
    }
    
    /*public func ==(lhs: Self, rhs: Self) -> Bool {
    return lhs.hashValue == rhs.hashValue
    }*/
    
    public var asString: String? {
        let cstring = UnsafeMutablePointer<Int8>.alloc(25)
        defer {
            cstring.dealloc(25)
        }
        bson_oid_to_string(oid, cstring)
        return String.fromCString(cstring)
    }
    
    //TODO: expose generation time
}