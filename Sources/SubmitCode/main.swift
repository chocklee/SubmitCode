import SwiftShell
import ArgumentParser

/// USAGE: SubmitCode [--is-submit] [--rb-id <rb-id>]
struct SubmitCode: ParsableCommand {
    @Flag(help: "Flag whether it is a submit flow")
    var isSubmit = false

    @Option(help: "Review bord id")
    var rbID: String?

    func run() throws {
        Git.gitPull()
        if isSubmit {
            Git.gitReview(rbID)
            Git.gitSubmit()
        } else {
            Rbt.rbtPost(rbID)
        }
    }
}

SubmitCode.main()
