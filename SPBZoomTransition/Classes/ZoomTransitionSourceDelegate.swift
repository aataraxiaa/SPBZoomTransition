//
//  ZoomTransitionSourceDelegate.swift
//  Pods
//
//  Created by Pete Smith on 31/07/2016.
//
//

import UIKit

@objc public protocol ZoomTransitionSourceDelegate: NSObjectProtocol {

    func transitionSourceImageView() -> UIImageView
    func transitionSourceImageViewFrame(forward: Bool) -> CGRect
    @objc optional func transitionSourceWillBegin()
    @objc optional func transitionSourceDidEnd()
    @objc optional func transitionSourceDidCancel()
}
