import SpriteKit

class LiquidShapeScene : SKScene {
    var splash: SplashShapeNode
    
    override init(size: CGSize) {
        self.splash = SplashShapeNode(size: CGSize(width: size.width, height: 200))
        
        super.init(size: size)
        // self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
//        let polygon = Polygon(points: [
//            CGPoint(x: 0, y: 0),
//            CGPoint(x: 100, y: 0),
//            CGPoint(x: 50, y: 50),
//            ])
//        let path = polygon.createPath()
//        let shape = SKShapeNode(path: path)
//        // self.addChild(shape)
//        
//        let circle = LiquidShapeNode(circleRadius: 100, numPoints: 4)
//        self.addChild(circle)
        
        self.splash.fillColor = UIColor.redColor()
        self.splash.strokeColor = UIColor.redColor()
        self.addChild(self.splash)
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(currentTime: NSTimeInterval) {
        let r = arc4random_uniform(100)
        if r < 3 {
            let i = arc4random_uniform(UInt32(splash.wave.springs.count))
            let spring = splash.wave.springs[Int(i)]
            spring.height = 100
            splash.wave.springs[Int(i)] = spring
        }
                
        self.splash.wave.updateSprings(0.1)
        self.splash.path = self.splash.wave.createPath()
    }
}