//
//  NibLoadable.swift
//  FightAcademy
//
//  Created by Павел Снижко on 19.03.2021.
//
import UIKit

protocol NibLoadable: class {
    static var nib: UINib { get }
    static var name: String { get }
}

extension NibLoadable {
    static var nib: UINib {
        return UINib(nibName: name, bundle: Bundle.init(for: self))
    }
    
    static var name: String {
        return String(describing: self)
    }
}

extension NibLoadable where Self: UIView {
    static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError()
        }
        
        return view
    }
}
