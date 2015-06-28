import SpriteKit

class LiquidShapeScene : SKScene {
    override init(size: CGSize) {
        super.init(size: size)
        
        let polygon = Polygon(points: [
            CGPoint(x: 0, y: 0),
            CGPoint(x: 100, y: 0),
            CGPoint(x: 50, y: 50),
            ])
        let shape = SKShapeNode(path: polygon.createPath())
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.addChild(shape)
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}