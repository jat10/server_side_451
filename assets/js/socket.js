import {Socket, LongPoller, Presence} from "phoenix"
class App {
  constructor(){
    this.number_access = 0
    // @TODO generate websocket protocol according to env. wss:// when secure env.
    this.socket = new Socket("/socket", {
      logger: ((kind, msg, data) => { console.log(`${kind}: ${msg}`, data) })
    })

    this.socket.connect() 
    this.channel = this.socket.channel("channel:2",{user_id: 0})


    this.channel.join()
    .receive("ok", resp => { console.log("Joined successfully", resp) })
    .receive("error", resp => { console.log("Unable to join", resp) })


    this.channel.on('init', payload => {
        this.init();
    })
  }

  init(){
    let status = $("#rt-checkout-status")
    let chatInput = $("#rt-checkout-message-input");
    let messagesContainer = $(".rt-checkout-messages");
    let channel1 = this.channel;

    this.socket.onOpen( ev => console.log("OPEN", ev) )
    this.socket.onError( ev => console.log("ERROR", ev) )
    this.socket.onClose( e => console.log("CLOSE", e))

    this.channel.push("welcome:msg", {body: chatInput.val()});
    this.channel.onError(e => console.log("something went wrong", e))
    this.channel.onClose(e => console.log("channel closed", e))

    chatInput.off("keypress").on("keypress", event => {
      if(event.keyCode === 13){
        this.channel.push("new:msg", {user: "user" ,body: chatInput.val()});
        chatInput.val("");
      }
    });

    this.channel.on("new:msg", msg => {
      messagesContainer.append(this.messageTemplate(msg))
      
    })

    this.channel.on("msg", msg => {
      console.log("I am in socket.js")
    })

  }

  sanitize(html){ 
    return $("<div/>").text(html).html() 
  }

  messageTemplate(msg){
    let username = this.sanitize(msg.user)
    let body     = this.sanitize(msg.body)
    var side = ""
    if(username == "BOT"){
      side = "left"
    } else {
      side = "right"
    }
    console.log(username)
    return(`<li class="rt-checkout-message rt-checkout-`+side+ ` rt-checkout-appeared">
      <div class="rt-checkout-avatar"></div>
      <div class="rt-checkout-text_wrapper">
      <div class="rt-checkout-text">${body}</div>
      </div>
      </li>`)
  }

  print(x){
    return(`<ol><li>${x}</li></ol>`)
  }

  scroll(){
    $(".rt-checkout-messages").animate({
        scrollTop: 10000000
      }, 200);
  }
}

let x;

$(() => x = new App())

export default App


