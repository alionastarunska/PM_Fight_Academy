import UIKit
import SwiftMessages

enum State {
    case normal
    case error
}

protocol ErrorDisplayingInput: class {
    var state: State { get set }
    var validationKey: String { get set }
    func set(errorText: String)
}

protocol ErrorDisplaying where Self: UIViewController {
    func show(errorString: String)
    func show(error: APIError)
    func show(validationErrors: [ValidationError]) -> String?
    
    var inputs: [ErrorDisplayingInput] { get }
}

extension ErrorDisplaying {
    
    func show(errorString: String) {
        guard !errorString.isEmpty else { return }
        var config = SwiftMessages.Config()
        config.presentationStyle = .top
        config.duration = .seconds(seconds: 4)
        config.interactiveHide = true
        config.presentationContext = .window(windowLevel: .normal)
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureContent(title: nil, body: errorString, iconImage: Asset.Assets.error.image,
                              iconText: nil, buttonImage: nil, buttonTitle: nil, buttonTapHandler: nil)
        view.shadowColor = .black
        view.shadowRadius = 8.0
        view.shadowOpacity = 0.4
        view.shadowOffset = CGSize(width: 1, height: 6)
        SwiftMessages.sharedInstance.pauseBetweenMessages = 0.1
        SwiftMessages.show(config: config, view: view)
    }
    
    func show(error: APIError) {
        if let error = error as? BackendError {
            let unusedMessage = show(validationErrors: error.validationErrors)
            if unusedMessage.empty {
                show(errorString: error.message)
            } else {
                show(errorString: [error.message, unusedMessage].compactMap({ $0 }).joined(separator: "\n"))
            }
        } else {
            show(errorString: error.message)
        }
    }
    
    func show(validationErrors: [ValidationError]) -> String? {
        var errors = validationErrors
        for input in inputs {
            if let index = errors.firstIndex(where: { $0.key == input.validationKey }) {
                input.state = .error
                input.set(errorText: errors[index].value)
                errors.remove(at: index)
            } else {
                input.set(errorText: "")
                input.state = .normal
            }
        }
        return errors.compactMap({ $0.value }).joined(separator: "\n")
    }
    
    var inputs: [ErrorDisplayingInput] { return [] }
}

enum InputValidation: String {
    case email
    case password
    case confirm
    case zip
    case firstName = "first_name"
    case lastName = "last_name"
    case avatar
    case token
}
