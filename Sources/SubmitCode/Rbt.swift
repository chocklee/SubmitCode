//
//  Rbt.swift
//  
//
//  Created by Changhao Li on 2021/8/4.
//

import SwiftShell

struct Rbt {
    static func rbtPost(_ rbID: String? = nil) {
        if rbID != nil, let rbID = rbID {
            guard rbID.count > 1 && rbID.count <= 7 else {
                exit(errormessage: "rb ID is incorrect")
            }
            let rbtPostRunOutput = run(bash: "rbt post -r \(rbID)")
            guard rbtPostRunOutput.succeeded else {
                exit(errormessage: rbtPostRunOutput.stderror)
            }
            print(rbtPostRunOutput.stdout)
        } else {
            let rbtPostRunOutput = run(bash: "rbt post")
            guard rbtPostRunOutput.succeeded else {
                exit(errormessage: rbtPostRunOutput.stderror)
            }
            print(rbtPostRunOutput.stdout)
        }
    }
}

