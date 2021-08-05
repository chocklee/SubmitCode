//
//  SubmitCode.swift
//  
//
//  Created by Changhao Li on 2021/8/5.
//

import ArgumentParser

struct SubmitCode: ParsableCommand {
    static var configuration = CommandConfiguration(
        subcommands: [Crp.self, Commit.self, Post.self, Submit.self, Push.self, Cgp.self],
        defaultSubcommand: Crp.self)
}

struct Options: ParsableArguments {
    @Argument(help: "Commit message")
    var message: String

    @Flag(name: .shortAndLong, help: "Flag whether to amend code")
    var amend: Bool = false
}

extension SubmitCode {
    struct Crp: ParsableCommand {
        static var configuration = CommandConfiguration(commandName: "crp", abstract: "Git commit and post code to review board")

        @OptionGroup var options: Options

        @Option(name: .shortAndLong, help: "Review board ID")
        var id: String?

        func run() throws {
            Git.gitAdd()
            Git.gitCommit(options.message, isAmend: options.amend)
            Git.gitPull()
            Rbt.rbtPost(id)
        }
    }

    struct Cgp: ParsableCommand {
        static var configuration = CommandConfiguration(commandName: "cgp", abstract: "Commit and push code")

        @OptionGroup var options: Options

        func run() throws {
            Git.gitAdd()
            Git.gitCommit(options.message, isAmend: options.amend)
            Git.gitPull()
            Git.gitPush()
        }
    }

    struct Commit: ParsableCommand {
        static var configuration = CommandConfiguration(commandName: "gc", abstract: "Git commit code")

        @OptionGroup var options: Options

        func run() throws {
            Git.gitAdd()
            Git.gitCommit(options.message, isAmend: options.amend)
        }
    }

    struct Post: ParsableCommand {
        static var configuration = CommandConfiguration(commandName: "rp",abstract: "Post code to review board")

        @Option(name: .shortAndLong, help: "Review Board ID")
        var id: String?

        func run() throws {
            Git.gitPull()
            Rbt.rbtPost(id)
        }
    }

    struct Submit: ParsableCommand {
        static var configuration = CommandConfiguration(commandName: "gs", abstract: "Git submit code")

        @Argument(help: "Review board ID")
        var id: String

        func run() throws {
            Git.gitPull()
            Git.gitReview(id)
            Git.gitSubmit()
        }
    }

    struct Push: ParsableCommand {
        static var configuration = CommandConfiguration(commandName: "gp", abstract: "Git Push code")

        func run() throws {
            Git.gitPull()
            Git.gitPush()
        }
    }
}
