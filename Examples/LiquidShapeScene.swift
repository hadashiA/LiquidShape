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
        shape.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        self.addChild(shape)
        
        println(polygon.controls)
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}