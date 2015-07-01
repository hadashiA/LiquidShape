import UIKit
import SpriteKit

class LiquidPolygonNodeViewController: UIViewController {
    @IBOutlet weak var sceneView: SKView!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let scene = LiquidPolygonScene(size: self.view.frame.size)
        self.sceneView.presentScene(scene)
    }
}

