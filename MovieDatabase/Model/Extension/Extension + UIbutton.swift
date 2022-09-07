//
//  Extension + UIbutton.swift
//  MovieDatabase
//
//  Created by Ilya Vasilev on 06.09.2022.
//

import Foundation
import UIKit

//MARK: Extension + UIButton
extension UIButton {
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2
        pulse.fromValue = 0.98
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
}
