import SpriteKit

class LiquidPolygonScene : SKScene {
    override init(size: CGSize) {
        super.init(size: size)
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.backgroundColor = UIColor.whiteColor()
        
        let polygon = LiquidPolygonNode(circleRadius: 100, numPoints: 8)
        polygon.fillColor = UIColor.blueColor()
        
        let action = SKAction.customActionWithDuration(1) {
            (node: SKNode!, elapsed: CGFloat) in
            
            if let polygonNode = node as? LiquidPolygonNode {
                polygonNode.points
            }
        }
        
        self.addChild(polygon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}