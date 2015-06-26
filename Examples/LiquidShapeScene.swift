import SpriteKit

class LiquidShapeScene : SKScene {
    override init(size: CGSize) {
        super.init(size: size)
        
        let shape = SKShapeNode(circleOfRadius: 100)
        shape.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        self.addChild(shape)
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}