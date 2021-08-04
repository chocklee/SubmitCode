import SwiftShell
import ArgumentParser

/// USAGE: SubmitCode [--submit] [--id <id>]
struct SubmitCode: ParsableCommand {
    @Flag(help: "Flag whether to submit code")
    var submit = false

    @Option(help: "Review Board ID")
    var id: String?

    func run() throws {
        Git.gitPull()
        if submit {
            Git.gitReview(id)
            Git.gitSubmit()
        } else {
            Rbt.rbtPost(id)
        }
    }
}

SubmitCode.main()
