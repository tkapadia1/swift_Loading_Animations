//
//  AnimatedCircleCompletionLayer.swift
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

class AnimatedCircleCompletionLayer: AnimatedProgressLayer {
    // NSManaged informs the compiler these values will be set
    // at runtime, and removes the "no initializers" compiler error
    @NSManaged var strokeWidth: CGFloat

    override init(layer: Any) {
        super.init(layer: layer)

        if let layer = layer as? AnimatedCircleCompletionLayer {
            strokeWidth = layer.strokeWidth
        }
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        
        // Make ctx the current context
        UIGraphicsPushContext(ctx)
        
        // The path describes the loading indicator shape
        // at a specific progress value
        var path: UIBezierPath
        
        // Computes radius, the distance from the center of
        // the bounds to the closest side minus strokeWidth
        let minSideLength = min(
            bounds.size.width,
            bounds.size.height
        )

        let radius = (minSideLength / 2.0) - strokeWidth
        
        // From start (progress 0) to full circle (progress 0.5)
        if progress < 0.5 {
            let sectionProgress = progress * 2

            path = UIBezierPath(
                arcCenter: bounds.center,
                radius: radius,
                startAngle: 1.5 * .pi,
                endAngle: (2 * .pi * sectionProgress) - (0.5 * .pi),
                clockwise: true
            )
        }
            
        else if progress == 0.5 {
            let halfSideLength = (minSideLength / 2.0)
            let rect =  CGRect(
               x: bounds.center.x - halfSideLength + strokeWidth,
               y: bounds.center.y - halfSideLength + strokeWidth,
               width: minSideLength - 2*strokeWidth,
               height: minSideLength - 2*strokeWidth
            )
            
            path = UIBezierPath(ovalIn: rect)
        }
            
        // From full circle (progress 0.5) to start (progress 1.0)
        else {
            let sectionProgress = (0.5 - progress) * 2
            path = UIBezierPath(
                arcCenter: bounds.center,
                radius: radius,
                startAngle: (1.5 * .pi) - (2 * .pi * sectionProgress),
                endAngle: 1.5 * .pi,
                clockwise: true
            )
        }
        
        // Draw the computed path
        draw(path: path, ctx: ctx)
        
        // Remove ctx as the current context
        UIGraphicsPopContext()
    }
    
    internal func draw(path: UIBezierPath, ctx: CGContext) {
        // Set color as the color of the stroke
        ctx.setStrokeColor(color)
        
        // Configures the line to be drawn at path
        path.lineWidth = strokeWidth
        path.lineCapStyle = .round
        
        // Outlines the path using the color set
        path.stroke()
    }
    
    override class func customAnimatable(key: String) -> Bool {
        if key == #keyPath(strokeWidth) { return true }
        return super.customAnimatable(key: key)
    }
}
