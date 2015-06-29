import SpriteKit

class LiquidShapeScene : SKScene {
    override init(size: CGSize) {
        super.init(size: size)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let polygon = Polygon(points: [
            CGPoint(x: 0, y: 0),
            CGPoint(x: 100, y: 0),
            CGPoint(x: 50, y: 50),
            ])
        let path = polygon.createPath()
        let shape = SKShapeNode(path: path)
        // self.addChild(shape)
        
        let circle = LiquidShapeNode(circleRadius: 100, numPoints: 4)
        self.addChild(circle)
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}