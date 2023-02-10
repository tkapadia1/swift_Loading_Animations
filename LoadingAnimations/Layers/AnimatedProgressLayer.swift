//
//  AnimatedProgressLayer.swift
//  LoadingAnimations
//

// Copyright (c) 2021 Robert Pieta, AdvancedSwift, https://www.advancedswift.com
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// Attribution, reasonable to the medium, with to the extent reasonably practicable
// a link to https://www.advancedswift.com, shall be provided in all distributions
// or public display of copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

class AnimatedProgressLayer: CALayer {
    // NSManaged informs the compiler these values will be set
    // at runtime, and removes the "no initializers" compiler error.
    // NSManaged is also used to help make these properties are animatable.
    @NSManaged var progress: CGFloat
    @NSManaged var color: CGColor

    override init(layer: Any) {
        super.init(layer: layer)

        // Support layer initialization by copy
        if let layer = layer as? AnimatedProgressLayer {
            progress = layer.progress
            color = layer.color
        }
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Redraw every time progress or tintColor change
    override class func needsDisplay(forKey key: String) -> Bool {
        if customAnimatable(key: key) { return true }
        return super.needsDisplay(forKey: key)
    }
    
    // Override to return an animation for key paths that are animatable.
    override func action(forKey event: String) -> CAAction? {
        if type(of: self).customAnimatable(key: event) {
            
            // To return a properly configured animation, this method needs to get a reference
            // to the existing animation applied. An API to do this directly is not public.
            // A common workaround is to get the action for the key path backgroundColor because
            // the action for backgroundColor is a CABasicAnimation and backgroundColor has been
            // a property since iOS 2.0.
            let animationReference = action(forKey: #keyPath(backgroundColor)) as? CABasicAnimation
            guard let animation = animationReference?.copy() as? CABasicAnimation else {
                setNeedsDisplay()
                return nil
            }

            // Set the key path of the animation to the key path
            // for the action
            animation.keyPath = event
            
            // presentation() returns the current state of the layer with animations
            // applied, and so presentation.value(forKeyPath: event) is the current
            // value considering animations for the key path event.
            if let presentation = presentation() {
                animation.fromValue = presentation.value(forKeyPath: event)
            }
            // However, presentation() may be nil if the layer is not yet drawing.
            // In this scenario, set the fromValue to the current value of the
            // key path event.
            else {
                animation.fromValue = value(forKeyPath: event)
            }

            return animation
        }
        
        return super.action(forKey: event)
    }
    
    // Return true for custom key paths that are animatable
    internal class func customAnimatable(key: String) -> Bool {
        if key == #keyPath(progress) { return true }
        else if key == #keyPath(color) { return true }
        return false
    }
}
