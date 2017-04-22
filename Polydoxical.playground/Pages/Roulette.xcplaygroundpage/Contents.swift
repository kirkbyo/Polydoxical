/*:
 ## Roulette
 The circle is the basis for a lot of important inventions that are vital in our day to day lives. The fact that there are no edges on it allows for it to be the optimal shape when rolling against a flat surface. When a circle is moving against a surface, the line drawn from a fixed point is called a **roulette**.
 
 The roulette traced by a point on a circle that is rolling on a flat surface is referred as a trochoid. A trochoid has three subcategories: **curtate**, **prolate** or a **cycloid**. A curtate roulette is traced when the tracing point is smaller than the radius. Meanwhile, a prolate curve is when the tracing point is larger than the radius. Finally, a cycloid is traced when the radius is equal to the tracing point.
 */

//: + callout(Create your own!): Try drawing your own trochoids! Don't go too fast or you'll lose precision.

//: [Previous](@previous) | [Next](@next)

import PlaygroundSupport

let controller = RouletteController()

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = controller
