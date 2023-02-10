//
//  AnimatedProgressView.swift
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

class AnimatedProgressView: UIView {
    @objc dynamic var progress: CGFloat {
        set { progressLayer.progress = newValue }
        get { return progressLayer.progress }
    }
    
    /// Display color of the progress bar. Animatable.
    @objc dynamic var color: UIColor {
        set { progressLayer.color = newValue.cgColor }
        get { return UIColor(cgColor: progressLayer.color) }
    }

    // Convenience variable
    internal var progressLayer: AnimatedProgressLayer {
        return layer as! AnimatedProgressLayer
    }
    
    // Overriding the layer class means AnimatedProgressLayer
    // will be instantiated as the layer property for this view
    override public class var layerClass: AnyClass {
        return AnimatedProgressLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        progress = 0
        color = .blue
        
        // Default the background color to clear
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func progressForever(interval: CFTimeInterval = 4.0, curve: CAMediaTimingFunctionName = .easeOut) {
        let progressAnimationKey = "progress-loop"
        
        // Only one progress forever animation can be active at a time
        guard layer.animation(forKey: progressAnimationKey) == nil else { return }
        
        let progressAnimation = CABasicAnimation(keyPath: "progress")
        
        // Animate from 0 (start) to 1 (end)
        progressAnimation.fromValue = 0.0
        progressAnimation.toValue = 1.0
        
        // The duration is the length of cycle where
        // progress goes from 0 to 1
        progressAnimation.duration = interval
        
        // Set repeat to Float.infinity to repeat "forever"
        progressAnimation.repeatCount = Float.infinity
        
        // The timingFunction, ie curve, changes how long it takes
        // to complete for each step of the animation.
        progressAnimation.timingFunction = CAMediaTimingFunction(name: curve)

        layer.add(progressAnimation, forKey: progressAnimationKey)
    }
    
    func rotateForever(interval: CFTimeInterval = 4.0, curve: CAMediaTimingFunctionName = .linear) {
        let rotateAnimationKey = "rotate-loop"
        
        // Only one rotate forever animation can be active at a time
        guard layer.animation(forKey: rotateAnimationKey) == nil else { return }
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        
        // Animate from 0 (start) to 2 * pi (end)
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        
        // The duration is the length of cycle where
        // progress goes from 0 to 1
        rotateAnimation.duration = interval
        
        // Set repeat to Float.infinity to repeat "forever"
        rotateAnimation.repeatCount = Float.infinity

        layer.add(rotateAnimation, forKey: nil)
    }
}
