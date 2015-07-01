import SpriteKit

public class SplashShapeNode : SKShapeNode {
    private var size: CGSize
    private var wave: Wave
    private var update: SKAction!
    
    public init(size: CGSize, numSprings: Int = 340, random: Bool = true) {
        self.size = size
        self.wave = Wave(size: size, waveLength: numSprings)

        super.init()
        
        self.path = self.wave.createPath()
        
        let sequence = [
            SKAction.runBlock { [weak self] in
                if random {
                    let r = arc4random_uniform(100)
                    if r < 3 {
                        let i = arc4random_uniform(UInt32(numSprings))
                        self?.wave.springs[Int(i)].height = 100
                    }
                }
                if let shape = self {
                    shape.wave.updateSprings(0.1)
                    shape.path = shape.wave.createPath()
                }
            },
            SKAction.waitForDuration(0)
        ]
        
        self.update = SKAction.repeatActionForever(SKAction.sequence(sequence))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func start() {
        if self.hasActions() {
            return
        }
        self.runAction(self.update)
    }
    
    public func stop() {
        self.removeAllActions()
    }
    
    public func splashAt(x: CGFloat, height: CGFloat = 100) {
        let i = Int(round((x / self.size.width) * CGFloat(self.wave.springs.count)))
        if i > 0 && i < self.wave.springs.count {
            self.wave.springs[Int(i)].height = height
        }
    }
}
