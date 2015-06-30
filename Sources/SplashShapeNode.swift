import SpriteKit

class SplashShapeNode : SKShapeNode {
    var size: CGSize
    var wave: Wave
    
    private var update: SKAction!
    
    init(size: CGSize, waveLength: Int = 340) {
        self.size = size
        self.wave = Wave(size: size, waveLength: waveLength)

        super.init()
        
        self.path = self.wave.createPath()
        
        let updatePath = SKAction.runBlock { [weak self] in
            if let shape = self {
                shape.wave.updateSprings(0.1)
                shape.path = shape.wave.createPath()
            }
        }
        let wait = SKAction.waitForDuration(0)
        self.update = SKAction.repeatActionForever(SKAction.sequence([updatePath, wait]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func splashAt(x: CGFloat, height: CGFloat = 100) {
        let i = Int(round((x / self.size.width) * CGFloat(self.wave.springs.count)))
        if i > 0 && i < self.wave.springs.count {
            self.wave.springs[Int(i)].height = height
        }
    }
    
    func stop() {
        self.removeActionForKey("update")
    }
    
    func start() {
        if self.actionForKey("update") != nil {
            return
        }
        self.runAction(self.update, withKey: "update")
    }
}
