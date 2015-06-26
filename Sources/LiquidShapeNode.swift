import SpriteKit

public class LiquidShapeNode : SKShapeNode {
    struct ControlPoints {
        var left: CGPoint
        var right: CGPoint
        
        init(left: CGPoint, right: CGPoint) {
            self.left = left
            self.right = right
        }
        
        init(a: CGPoint, b: CGPoint, c: CGPoint) {
            
            self.init(left: CGPointZero, right: CGPointZero)
        }
    }
    
    var points: [CGPoint] {
        didSet {
            self.plot()
        }
    }
    
    private var controls = [ControlPoints]()
    
    init(points: [CGPoint]) {
        self.points = points
        super.init()
        
        self.plot()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func plot(closed: Bool = true) {
        //        self.controls = points.map { (point: CGPoint) -> ControlPoints in
        //            return ControlPoints(left: CGPointZero, right: CGPointZero)
        //        }
        
        let count = self.points.count
        for i in 0..<count {
            let point = self.points[i]
            let prev = closed ? ((i - 1) % count) : max(i - 1, 0)
            let next = closed ? ((i + 1) % count) : min(i + 1, count - 1)
            
            let a = self.points[prev]
            let b = point
            let c = self.points[next]
            
            let controlPoints = ControlPoints(a: a, b: b, c: c)
        }
    }
    
    private func angleBetween(a: CGPoint, b: CGPoint) -> CGFloat {
        return atan2(a.y - b.y, a.x - b.y)
    }
}