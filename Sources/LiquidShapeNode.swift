import SpriteKit

public class LiquidShapeNode : SKShapeNode {
    var polygon: Polygon
    
    init(points: [CGPoint]) {
        self.polygon = Polygon(points: points)
        super.init()
        self.path = self.polygon.createPath()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}