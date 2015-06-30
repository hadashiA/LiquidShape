import SpriteKit

class LiquidShapeScene : SKScene {
    var splash: SplashShapeNode
    
    override init(size: CGSize) {
        self.splash = SplashShapeNode(size: CGSize(width: size.width, height: 200))
        
        super.init(size: size)

        self.splash.fillColor = UIColor.blueColor()
        self.splash.fillColor = UIColor.blueColor()
        self.splash.start()
        self.addChild(self.splash)
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(currentTime: NSTimeInterval) {
        let r = arc4random_uniform(100)
        if r < 3 {
            let i = arc4random_uniform(UInt32(splash.wave.springs.count))
            var spring = splash.wave.springs[Int(i)]
            spring.height = 100
            splash.wave.springs[Int(i)] = spring
        }
                
        self.splash.wave.updateSprings(0.1)
        self.splash.path = self.splash.wave.createPath()
    }
}