import SpriteKit

public class LiquidPolygonNode : SKShapeNode {
    public var points: [CGPoint] {
        return self.polygon.points
    }
    
    private var polygon: LiquidPolygon
    
    init(points: [CGPoint]) {
        self.polygon = LiquidPolygon(points: points)
        super.init()
        self.path = self.polygon.createPath()
    }
    
    convenience init(circleRadius radius: CGFloat, numPoints: Int = 8) {
        let points: [CGPoint] = map(0..<numPoints) { (i: Int) -> CGPoint in
            let percent = Double(i) / Double(numPoints)
            let theta = percent * M_PI * 2
            
            return CGPoint(
                x: radius * CGFloat(cos(theta)),
                y: radius * CGFloat(sin(theta)))
        }
        self.init(points: points)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func movePointAt(i: Int, to: CGPoint) {
        self.polygon.points[i] = to
        self.path = self.polygon.createPath()
    }
}