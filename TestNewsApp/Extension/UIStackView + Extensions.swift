//
//  UIStackView + Extensions.swift
//  TrainingApp
//
//  Created by demasek on 18.10.2022.
//

import UIKit
//let stackView = UIStackView()
//stackView.addArrangedSubview(YourView)
//stackView.addArrangedSubview(YourView2)
//stackView.axis = .horizontal
//stackView.spacing = 10
//stackView.translatesAutoresizingMaskIntoConstraints = false

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
