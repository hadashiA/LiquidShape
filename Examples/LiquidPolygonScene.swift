import SpriteKit

class LiquidPolygonScene : SKScene {
    var polygon = LiquidPolygonNode(circleRadius: 100, numPoints: 16)
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.backgroundColor = UIColor.whiteColor()
        
        self.polygon.fillColor = UIColor.blueColor()
        self.polygon.name = "polygon"
        self.addChild(self.polygon)
        
        self.morph()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func morph() {
        var destinations: [(CGPoint, CGPoint)] = map(enumerate(self.polygon.points)) {
            (i: Int, point: CGPoint) -> (CGPoint, CGPoint) in
            let percent = Double(i + 1) / Double(self.polygon.points.count)
            let theta = percent * M_PI * 2
            
            let neutralRadius = self.size.width / 6
            let randomRadius = CGFloat(arc4random_uniform(UInt32(self.size.width / 3))) + self.size.width / 6

            let nx = CGFloat(cos(theta))
            let ny = CGFloat(sin(theta))
            return (
                CGPoint(x: nx * neutralRadius, y: ny * neutralRadius),
                CGPoint(x: nx * randomRadius, y: ny * randomRadius))
        }

        let move = SKAction.customActionWithDuration(1) {
            (node: SKNode!, elapsed: CGFloat) in
            
            if let polygonNode = node as? LiquidPolygonNode {
                for i in 0..<polygonNode.points.count {
                    let (src, dest) = destinations[i]
                    let x = src.x + ((dest.x - src.x) * elapsed)
                    let y = src.y + ((dest.y - src.y) * elapsed)
                    polygonNode.movePointAt(i, to: CGPoint(x: x, y: y))
                }
            }
        }
        
        let reset = SKAction.customActionWithDuration(1) {
            (node: SKNode!, elapsed: CGFloat) in
            
            if let polygonNode = node as? LiquidPolygonNode {
                for i in 0..<polygonNode.points.count {
                    let (src, dest) = destinations[i]
                    let x = dest.x + ((src.x - dest.x) * elapsed)
                    let y = dest.y + ((src.y - dest.y) * elapsed)
                    polygonNode.movePointAt(i, to: CGPoint(x: x, y: y))
                }
            }
        }
        
        let wait = SKAction.waitForDuration(1)
        
        let next = SKAction.runBlock {
            [weak self] in
            self?.morph()
        }
        self.polygon.runAction(SKAction.sequence([move, reset, next]))
    }
}