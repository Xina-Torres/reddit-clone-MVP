//
//  Spinner.swift
//  Reddit-Clone
//
//  Created by Maria Xina Rae Torres on 06/06/2018.
//  Copyright © 2018 Maria Xina Rae Torres. All rights reserved.
//

//
//  Spinner.swift
//
//  Created by Michał Majchrzycki on 28.03.2018.
//  Copyright © 2018 Prograils.com. All rights reserved.
//  Check whole tutorial at: https://prograils.com/posts/reusable-activity-indicator-with-swift
import UIKit

open class Spinner {
    
    internal static var spinner: UIActivityIndicatorView?
    open static var style: UIActivityIndicatorViewStyle = .whiteLarge
    open static var baseBackColor = UIColor.gray.withAlphaComponent(0.5)
    open static var baseColor = UIColor.white
    
    open static func start(style: UIActivityIndicatorViewStyle = style, backColor: UIColor = baseBackColor, baseColor: UIColor = baseColor) {
        NotificationCenter.default.addObserver(self, selector: #selector(update), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        if spinner == nil, let window = UIApplication.shared.keyWindow {
            let frame = UIScreen.main.bounds
            spinner = UIActivityIndicatorView(frame: frame)
            spinner!.backgroundColor = backColor
            spinner!.activityIndicatorViewStyle = style
            spinner?.color = baseColor
            window.addSubview(spinner!)
            spinner!.startAnimating()
        }
    }
    
    open static func stop() {
        if spinner != nil {
            spinner!.stopAnimating()
            spinner!.removeFromSuperview()
            spinner = nil
        }
    }
    
    @objc open static func update() {
        if spinner != nil {
            stop()
            start()
        }
    }
}
