//
//  LoadingDisplaying.swift
//  StackOverflow-Search
//
//  Created by Aliona Starunska on 25.02.2021.
//

import UIKit
import NVActivityIndicatorView

public protocol LoadingDisplaying {
    func startLoading()
    func endLoading()
}

public extension LoadingDisplaying where Self: UIViewController {
    
    func startLoading() {
        guard view?.subviews.first(where: { $0.subviews.first is NVActivityIndicatorView }) == nil else { return }
        let contentView = UIView(frame: UIScreen.main.bounds)
        contentView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        let view = NVActivityIndicatorView(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 50)),
                                           type: .lineSpinFadeLoader, color: Asset.Colors.customYellow.color, padding: nil)
        contentView.addSubview(view)
        view.center(in: contentView.frame)
        
        self.view.addSubview(contentView)
        view.startAnimating()
        contentView.alpha = 0
        UIView.animate(withDuration: .duration) {
            contentView.alpha = 1
        }
    }
    
    func endLoading() {
        if let contentView = self.view.subviews.first(where: { $0.subviews.first is NVActivityIndicatorView }) {
            UIView.animate(withDuration: .duration, animations: {
                contentView.alpha = 0
            }, completion: { _ in
                let animationView = contentView.subviews.first as? NVActivityIndicatorView
                animationView?.stopAnimating()
                animationView?.removeFromSuperview()
                contentView.removeFromSuperview()
            })
        }
    }
}

// MARK: - Constants

private extension TimeInterval {
    static var duration: TimeInterval { return 0.33 }
}

private extension UIView {
    func center(in bounds: CGRect) {
        frame.origin.x = max(0, (bounds.size.width - frame.size.width) * 0.5)
        frame.origin.y = max(0, (bounds.size.height - frame.size.height) * 0.5)
    }
}
