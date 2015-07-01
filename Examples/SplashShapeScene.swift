import SpriteKit

class WaveNodeScene : SKScene {
    override init(size: CGSize) {
        let splash = SplashShapeNode(
            size: CGSize(width: size.width, height: 100),
            numSprings: 340,
            random: true)
        
        super.init(size: size)

        self.backgroundColor = UIColor.whiteColor()
        splash.fillColor = UIColor.blueColor()
        splash.fillColor = UIColor.blueColor()
        self.addChild(splash)
        splash.start()
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}