import UIKit

public class LiquidPolygon {
    struct ControlPoints {
        var left: CGPoint
        var right: CGPoint
    }
    
    public var points: [CGPoint] {
        didSet {
            self.plot()
        }
    }
    
    private(set) var controls = [ControlPoints]()
    private(set) var closed = true
    
    public init(points: [CGPoint]) {
        self.points = points
        self.plot()
    }

    public func createPath() -> CGPath {
        let path = UIBezierPath()

        for i in 0..<self.points.count {
            let b = self.points[i]
            if i == 0 {
                path.moveToPoint(b)
            } else {
                let (prev, next) = self.prevAndNextIndexAt(i)
                
                let a = self.points[prev]
                let c = self.points[next]
                
                let aControl = self.controls[prev]
                let bControl = self.controls[i]
                
                let v = CGPoint(
                    x: aControl.right.x + a.x,
                    y: aControl.right.y + a.y)
                
                let u = CGPoint(
                    x: bControl.left.x + b.x,
                    y: bControl.left.y + b.y)
                
                path.addCurveToPoint(b, controlPoint1: v, controlPoint2: u)
                
                if self.closed && i >= self.points.count - 1 {
                    let c = self.points[0]
                    let cControl = self.controls[0]
                    
                    let v = CGPoint(
                        x: bControl.right.x + b.x,
                        y: bControl.right.y + b.y)
                    
                    let u = CGPoint(
                        x: cControl.left.x + c.x,
                        y: cControl.left.y + c.y)

                    path.addCurveToPoint(c, controlPoint1: v, controlPoint2: u)
                    path.closePath()
                }
            }
        }

        return path.CGPath
    }
    
    private func prevAndNextIndexAt(i: Int) -> (Int, Int) {
        let count = self.points.count
        
        var prev = i - 1
        var next = i + 1
        
        if prev < 0 {
            prev += count
        }
        prev = self.closed ? (prev % count) : max(prev, 0)
        next = self.closed ? (next % count) : min(next, count - 1)
        
        return (prev, next)
    }
    
    private func plot() {
        self.controls = map(0..<self.points.count) {
            (i: Int) -> ControlPoints in
            
            let (prev, next) = self.prevAndNextIndexAt(i)
            let a = self.points[prev]
            let b = self.points[i]
            let c = self.points[next]
            
            let d1 = self.distanceBetween(a, and: b)
            let d2 = self.distanceBetween(c, and: b)
            
            if d1 < 0.0001 || d2 < 0.0001 {
                return ControlPoints(left: b, right: b)
            }
            
            let a1 = self.angleBetween(a, and: b)
            let a2 = self.angleBetween(c, and: b)
            
            var mid = (a1 + a2) * 0.5
            if (a2 < a1) {
                mid += CGFloat(M_PI_2)
            } else {
                mid -= CGFloat(M_PI_2)
            }
            
            let weight: CGFloat = 0.33
            
            let left = CGPoint(
                x: cos(mid) * d1 * weight,
                y: sin(mid) * d1 * weight)
            let right = CGPoint(
                x: cos(mid - CGFloat(M_PI)) * CGFloat(d2 * weight),
                y: sin(mid - CGFloat(M_PI)) * CGFloat(d2 * weight))
            
            return ControlPoints(left: left, right: right)
        }
    }
    
    private func angleBetween(a: CGPoint, and b: CGPoint) -> CGFloat {
        return atan2(a.y - b.y, a.x - b.x)
    }
    
    private func distanceBetween(a: CGPoint, and b: CGPoint) -> CGFloat {
        let dx = a.x - b.x
        let dy = a.y - b.y
        return sqrt(dx * dx + dy * dy)
    }
}