# PopUpMessageBox
İOS Beautiful animated replaceable message box


![alt tag](https://cloud.githubusercontent.com/assets/16580898/20037189/d00eb174-a423-11e6-8d3d-2a87c21f1ae8.png)

![alt tag](https://cloud.githubusercontent.com/assets/16580898/20037191/d96729cc-a423-11e6-8608-f813a1579b90.png)

```Swift
 puBox = PopUpMessageBox(to: self.view, icon: UIImage(named:"ms.png")!, title: "Send Message")
 
         puBox.setup()
        
         puBox.addSendHandle(target: self, selector: #selector(sendMsg))
         puBox.addCancelHandle(target: self, selector: #selector(cancelMsg))
```

TextView text

```Swift
  func sendMsg() {
        // Send Code
        
        print(puBox.msgText!)
        
    }
```

Cancel handle call remove function

```Swift
 func cancelMsg() {
        // Cancel Code
        
        puBox.remove()
        
    }
```

Change Icon,title vs.

```Swift
 PopUpMessageBox(to: self.view, icon: UIImage(named "ms.png")!, title: "Send", sendTitle: "Go", cancelTitle: "Cancel", sendColor: UIColor.black, cancelColor: UIColor.gray)
```
