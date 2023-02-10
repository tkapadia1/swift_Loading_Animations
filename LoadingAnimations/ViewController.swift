//
//  ViewController.swift
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

class ViewController: UIViewController {
    override func viewDidLoad() {
        // Configure the animated view
        let animatedStrokeAndColorView = AnimatedCircleCompletionView(
            frame: CGRect(x: 20, y: 40, width: 80, height: 80)
        )

        animatedStrokeAndColorView.color = .green
        animatedStrokeAndColorView.strokeWidth = 5
        animatedStrokeAndColorView.progress = 0.0

        view.addSubview(animatedStrokeAndColorView)

        // Start animations
        UIView.animate(
            withDuration: 3.0,
            delay: 0.0,
            options: [.repeat, .curveEaseInOut],
            animations: {
                animatedStrokeAndColorView.progress = 1.0
        }, completion: nil)

        UIView.animate(
            withDuration: 1.0,
            delay: 0.0,
            options: [.repeat, .autoreverse],
            animations: {
                animatedStrokeAndColorView.color = UIColor.blue
                animatedStrokeAndColorView.strokeWidth = 20
        }, completion: nil)

        animatedStrokeAndColorView.rotateForever()


        // Configure the animated view
        let animatedView = AnimatedCircleCompletionView(
            frame: CGRect(x: 40, y: 160, width: 80, height: 80)
        )

        animatedView.color = .orange
        animatedView.strokeWidth = 7.0

        view.addSubview(animatedView)

        // Start animations
        animatedView.progressForever(interval: 2.0)
        animatedView.rotateForever()
        
        
        // Configure the animated view
        let animatedViewWithGradient = GradientAnimatedCircleCompletionView(
            frame: CGRect(x: 20, y: 320, width: 120, height: 120)
        )

        animatedViewWithGradient.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        animatedViewWithGradient.strokeWidth = 8.0
        
        view.addSubview(animatedViewWithGradient)
        
        // Start animations
        UIView.animate(
            withDuration: 3.0,
            delay: 0.0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.0,
            options: [.repeat, .autoreverse],
            animations: {
                animatedViewWithGradient.progress = 0.5
        }, completion: nil)
    }
}
