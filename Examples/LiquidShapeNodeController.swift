import UIKit
import SpriteKit

class DetailViewController: UIViewController {
    @IBOutlet weak var sceneView: SKView!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let scene = LiquidShapeScene(size: self.view.frame.size)
        self.sceneView.presentScene(scene)
    }
}

