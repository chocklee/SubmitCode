import SwiftShell
import ArgumentParser

/// USAGE: submit-code <subcommand>
/// SUBCOMMANDS:
/// c                       Commit Code
/// p (default)             Post Code
/// s                       Submit Code
struct SubmitCode: ParsableCommand {
    static var configuration = CommandConfiguration(
        subcommands: [Commit.self, Post.self, Submit.self, Push.self],
        defaultSubcommand: Post.self)
}

extension SubmitCode {
    struct Commit: ParsableCommand {
        static var configuration = CommandConfiguration(commandName: "c", abstract: "Commit Code")

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
        static var configuration = CommandConfiguration(commandName: "p",abstract: "Post Code")

        @Option(name: .shortAndLong, help: "Review Board ID")
        var id: String?

        func run() throws {
            Git.gitPull()
            Rbt.rbtPost(id)
        }
    }

    struct Submit: ParsableCommand {
        static var configuration = CommandConfiguration(commandName: "s", abstract: "Submit Code")

        @Argument(help: "Review Board ID")
        var id: String

        func run() throws {
            Git.gitPull()
            Git.gitReview(id)
            Git.gitSubmit()
        }
    }

    struct Push: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "Push Code")
        func run() throws {
            Git.gitPull()
            Git.gitPush()
        }
    }
}

SubmitCode.main()
