import Foundation
import UIKit

class AlertPresenter: AlertPresenterProtocol {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func present(model: AlertModel) {
        let alert = UIAlertController(title: model.title, message: model.message, preferredStyle: .alert)
        alert.view.accessibilityIdentifier = "Game results"
        let action = UIAlertAction(title: model.buttonText, style: .default, handler: { _ in
            model.completion()
        })
        
        alert.addAction(action)
        viewController?.present(alert, animated: true)
    }
}
