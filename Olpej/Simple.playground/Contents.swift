import Olpej

let helloButton = button(
    .identifier("button"),
    .title("Hello", forState: .Normal),
    .backgroundColor(.blueColor()),
    .frame(x: 0, y: 0, width: 100, height: 50)
)

let layout = view(
    .identifier("view"),
    .backgroundColor(.whiteColor()),
    .frame(x: 0, y: 0, width: 400, height: 400)
).append([helloButton])


let output = layout.render()
