//
//  Git.swift
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

    static func gitReview(_ rbID: String) {
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

    static func gitAdd() {
        let gitAddRunOutput = run(bash: "git add .")
        guard gitAddRunOutput.succeeded else {
            exit(errormessage: gitAddRunOutput.stderror)
        }
        print("git add completed")
    }

    static func gitCommit(_ message: String, isAmend: Bool) {
        var command: String = "git commit\(isAmend ? " --amend" : "")"
        command.append(" -m \(message) --quiet")
        let gitCommitRunOutput = run(bash: command)
        guard gitCommitRunOutput.succeeded else {
            exit(errormessage: gitCommitRunOutput.stderror)
        }
        print("git commit completed")
    }

    static func gitPush() {
        let gitPushRunOutput = run(bash: "git push")
        guard gitPushRunOutput.succeeded else {
            exit(errormessage: gitPushRunOutput.stderror)
        }
        print(gitPushRunOutput.stdout)
        print("git push completed")
    }
}
