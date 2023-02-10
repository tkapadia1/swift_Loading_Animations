//
//  GradientAnimatedCircleCompletionLayer.swift
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

class GradientAnimatedCircleCompletionLayer: AnimatedCircleCompletionLayer {
    var gradient: CGGradient?
    
    override init(layer: Any) {
        super.init(layer: layer)

        if let layer = layer as? GradientAnimatedCircleCompletionLayer {
            gradient = layer.gradient
        }
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(path: UIBezierPath, ctx: CGContext) {
        guard let gradient = gradient else { return }
    
        // Configure the line properties
        ctx.setLineWidth(strokeWidth)
        ctx.setLineCap(.round)
        
        // Configure the drawing of the path and application
        // of the gradient
        ctx.addPath(path.cgPath)
        ctx.replacePathWithStrokedPath()
        
        ctx.clip()

        // Draw the gradient onto the path
        ctx.drawLinearGradient(
            gradient,
            start: bounds.origin,
            end: CGPoint(x: bounds.maxX, y: bounds.maxY),
            options: []
        )
    }
}
