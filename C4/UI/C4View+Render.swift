// Copyright © 2014 C4
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions: The above copyright
// notice and this permission notice shall be included in all copies or
// substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.

import UIKit

public extension C4View {
    public func render() -> C4Image? {
        guard let l = layer else {
            print("Could not retrieve layer for current object: \(self)")
            return nil
        }
        let graphicsSize = C4Size(floor(width),floor(height))
        UIGraphicsBeginImageContextWithOptions(CGSize(graphicsSize), false, UIScreen.mainScreen().scale)
        let context = UIGraphicsGetCurrentContext()!
        l.renderInContext(context)
        let uiimage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return C4Image(uiimage: uiimage)
    }
}

public extension C4Shape {
    public override func render() -> C4Image? {
        var graphicsSize = CGSize(C4Size(floor(width),floor(height)))
        var inset: CGFloat = 0
        if lineWidth > 0 && strokeColor?.alpha > 0.0 {
            inset = CGFloat(lineWidth/2.0)
            graphicsSize = CGRectInset(CGRect(frame), -inset, -inset).size
        }

        let scale = CGFloat(UIScreen.mainScreen().scale)
        UIGraphicsBeginImageContextWithOptions(graphicsSize, false, scale)
        let context = UIGraphicsGetCurrentContext()!
        CGContextTranslateCTM(context, CGFloat(-bounds.origin.x)+inset, CGFloat(-bounds.origin.y)+inset)
        shapeLayer.renderInContext(context)
        let uiimage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return C4Image(uiimage: uiimage)
    }
}
