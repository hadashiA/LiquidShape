import SpriteKit

public class LiquidShapeNode : SKShapeNode {
    var polygon: Polygon
    
    init(points: [CGPoint]) {
        self.polygon = Polygon(points: points)
        super.init()
        self.path = self.polygon.createPath()
    }
    
    convenience init(circleRadius radius: CGFloat, numPoints: Int = 8) {
        let points: [CGPoint] = map(0..<8) { (i: Int) -> CGPoint in
            let percent = CGFloat(i) / CGFloat(numPoints)
            let theta = percent * CGFloat(M_PI)
            
            return CGPoint(
                x: radius * cos(theta),
                y: radius * sin(theta))
        }
        self.init(points: points)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}