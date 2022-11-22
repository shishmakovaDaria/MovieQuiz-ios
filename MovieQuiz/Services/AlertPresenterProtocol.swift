import Foundation
import UIKit

protocol AlertPresenterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    func present(model: AlertModel)
}
