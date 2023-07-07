import UIKit

/*
 https://medium.com/cleansoftware/implement-the-command-design-pattern-in-swift-5-a3a07352af09
 
 Command
 
 the Command is a behavioral design pattern that helps us encapsulate actions (commands) and execute them at a later point in time.

 It involves the following components:

 Invoker — an object that executes its commands
 Command — an action that needs to be performed
 Receiver — an object that is being acted upon.
 */

class App {
    enum ModerationState {
        case submittedForReview
        case inReview
        case approved
        case rejected
    }
    
    var moderationState: ModerationState = .submittedForReview
}


class ModerationCommand {
    var app: App
    init(app: App) {
        self.app = app
    }
    
    public func execute() {}
}

class StartReviewCommand: ModerationCommand {
    override func execute() {
        app.moderationState = .inReview
        print("The app is in review")
    }
}

class RejectCommand: ModerationCommand {
    override func execute() {
        app.moderationState = .rejected
        print("The app was rejected")
    }
}

class ApproveCommand: ModerationCommand {
    override func execute() {
        app.moderationState = .approved
        print("The app was approved")
    }
}


class Moderator {
    var commands: [ModerationCommand] = [] {
        didSet {
            self.reviewApp()
        }
    }
    let app: App
    
    init(app: App) {
        self.app = app
    }
    
    func reviewApp() {
        let queue = DispatchQueue.global(qos: .background)
        let semaphore = DispatchSemaphore(value: 1)
        
        for (index, command) in commands.enumerated() {
            semaphore.wait()
            
            queue.asyncAfter(deadline: .now() + .seconds(index * 2)) {
                defer {
                    semaphore.signal()
                }
                
                command.execute()
            }
        }
    }
}

let moderator = Moderator(app: App())
moderator.commands = [
    StartReviewCommand(app: moderator.app),
    RejectCommand(app: moderator.app),
    StartReviewCommand(app: moderator.app),
    ApproveCommand(app: moderator.app)
]
