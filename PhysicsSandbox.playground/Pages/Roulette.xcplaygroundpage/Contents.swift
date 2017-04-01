/*:
 ## Roulette
 The circle has been around for a long time. It was has been known since before recorded history and is the basis for a lot of crucial inventions that are vital in are day to day lives. The fact that there are no edges on it allows for it to be the optimal shape when rolling against a flat surface. When a circle is rolling against a surface, the line drawn from a fixed point is called a **roulette**.
 
 
 The roulette traced by a point on a circle that is rolling on a flat surface is called a trochoid. A trochoid has three subcategories: **curtate**, **prolate** or a **cycloid**. A curtate roulette is traced when the tracing point is smaller then the radius. Meanwhile, a prolate curve is when the tracing point is larger then radius. Finally, a cycloid is traced when the radius is equal to the tracing point.
 */

//: + callout(Create your own!): Try drawing your own trochoids! Don't go to fast to fast or you'll lose percision.

//: [Next](@Introduction) | [Previous](@previous)

import PlaygroundSupport

let controller = RouletteController()

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = controller
