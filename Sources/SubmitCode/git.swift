//
//  git.swift
//  
//
//  Created by Changhao Li on 2021/8/4.
//

import SwiftShell

struct Git {
    static func gitPull() {
        let gitPullRunOutput = run(bash: "git pull -r")
        guard gitPullRunOutput.succeeded else {
            exit(errormessage: gitPullRunOutput.stderror)
        }
        print(gitPullRunOutput.stdout)
    }

    static func gitReview(_ rbID: String?) {
        guard let rbID = rbID else {
            exit(errormessage: "Missing rb id")
        }
        let gitReviewRunOutput = run(bash: "git review dcommit -r \(rbID)")
        guard gitReviewRunOutput.succeeded else {
            exit(errormessage: gitReviewRunOutput.stderror)
        }
        print(gitReviewRunOutput.stdout)
    }

    static func gitSubmit() {
        let gitSubmitRunOutput = run(bash: "git submit --async")
        guard gitSubmitRunOutput.succeeded else {
            exit(errormessage: gitSubmitRunOutput.stderror)
        }
        print(gitSubmitRunOutput.stdout)
    }
}
