import UIKit
import NVActivityIndicatorView

public protocol LoadingDisplaying {
    func startLoading()
    func endLoading()
}

public extension LoadingDisplaying where Self: UIViewController {
    
    func startLoading() {
        view.endEditing(true)
        guard let window = UIApplication.shared.delegate?.window,
            window?.subviews.first(where: { $0.subviews.first is NVActivityIndicatorView }) == nil else { return }
        let contentView = UIView(frame: UIScreen.main.bounds)
        contentView.backgroundColor = Asset.Colors.overlayDark.color
        let view = NVActivityIndicatorView(frame: CGRect(origin: .zero, size: CGSize(width: 80, height: 80)),
                                           type: .circleStrokeSpin, color: Asset.Colors.main.color, padding: nil)
        contentView.addSubview(view)
        view.center(in: contentView.frame)
        UIApplication.shared.delegate?.window?.map({ $0.addSubview(contentView) })
        view.startAnimating()
        contentView.alpha = 0
        UIView.animate(withDuration: .duration) {
            contentView.alpha = 1
        }
    }
    
    func endLoading() {
        UIApplication.shared.delegate?.window?.map({
            if let contentView = $0.subviews.first(where: { $0.subviews.first is NVActivityIndicatorView }) {
                UIView.animate(withDuration: .duration, animations: {
                    contentView.alpha = 0
                }, completion: { _ in
                    let animationView = contentView.subviews.first as? NVActivityIndicatorView
                    animationView?.stopAnimating()
                    animationView?.removeFromSuperview()
                    contentView.removeFromSuperview()
                })
            }
        })
    }
}

// MARK: - Constants

private extension TimeInterval {
    static var duration: TimeInterval { return 0.33 }
}
