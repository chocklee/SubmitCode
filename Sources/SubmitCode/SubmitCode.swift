//
//  SubmitCode.swift
//  
//
//  Created by Changhao Li on 2021/8/5.
//

import ArgumentParser

struct SubmitCode: ParsableCommand {
    static var configuration = CommandConfiguration(
        subcommands: [Cap.self, Commit.self, Post.self, Submit.self, Push.self],
        defaultSubcommand: Cap.self)
}

extension SubmitCode {
    struct Cap: ParsableCommand {
        static var configuration = CommandConfiguration(commandName: "cap", abstract: "Commit and post/push code")

        @Argument(help: "Commit message")
        var message: String

        @Flag(name: .shortAndLong, help: "Flag whether to amend code")
        var amend: Bool = false

        @Flag(name: .shortAndLong, help: "Flag whether to use git push")
        var push: Bool = false

        @Option(name: .shortAndLong, help: "Review board ID")
        var id: String?

        func run() throws {
            Git.gitAdd()
            Git.gitCommit(message, isAmend: amend)
            Git.gitPull()
            if push {
                Git.gitPush()
            } else {
                Rbt.rbtPost(id)
            }
        }
    }

    struct Commit: ParsableCommand {
        static var configuration = CommandConfiguration(commandName: "c", abstract: "Commit code")

        @Argument(help: "Commit message")
        var message: String

        @Flag(name: .shortAndLong, help: "Flag whether to amend code")
        var amend: Bool = false

        func run() throws {
            Git.gitAdd()
            Git.gitCommit(message, isAmend: amend)
        }
    }

    struct Post: ParsableCommand {
        static var configuration = CommandConfiguration(commandName: "p",abstract: "Post code")

        @Option(name: .shortAndLong, help: "Review Board ID")
        var id: String?

        func run() throws {
            Git.gitPull()
            Rbt.rbtPost(id)
        }
    }

    struct Submit: ParsableCommand {
        static var configuration = CommandConfiguration(commandName: "s", abstract: "Submit code")

        @Argument(help: "Review board ID")
        var id: String

        func run() throws {
            Git.gitPull()
            Git.gitReview(id)
            Git.gitSubmit()
        }
    }

    struct Push: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "Push code")

        func run() throws {
            Git.gitPull()
            Git.gitPush()
        }
    }
}
