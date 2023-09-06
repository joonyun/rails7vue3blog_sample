<template>
  <div id="container">
    <main>
      <header>
        <input type="text" v-model="name"  placeholder="이름">
      </header>
      <ul id="chat" ref="chatbox" >
        <li v-for="(msg, i) in messages"  :key="i" :class="name==msg.name ? 'me' : 'you' ">
          <div class="entete">
            <span :class="name==msg.name ? 'status blue' : 'status green' "></span>
            <h2 style="color: green" >{{ msg.name }}</h2>
            <h3 style="color: grey; margin-left:5px">{{ msg.spoke_day }}</h3>
          </div>
          <div class="triangle"></div>
          <div class="message" style="padding-bottom:0px">
            {{ msg.message }}
            <br>
            <div style="font-size:12px;color:white; text-align:right" >{{ msg.spoke_time }}</div>

          </div>
        </li>
        
      </ul>
      <footer>
        <input type="text" placeholder="Type your message" v-model="input_message" @keyup.enter="speak">
        <button @click="speak">전송</button>
      </footer>
    </main>
  </div>
</template>

<script  >
 export default {

   data(){
     return {
        name: '',
        input_message: '',
        messages: []
     }
   },

  mounted() {
    this.$cable.subscribe({
      channel: "ChatChannel",
      room: "test_chat",
    });
  }, 

  channels: {
    ChatChannel: {
      connected() {},
      rejected() {},
      received(data) {
        this.messages.push({
          name: data.body.name, 
          message: data.body.message, 
          spoke_day: data.body.spoke_day,
          spoke_time: data.body.spoke_time,
        });
        this.$nextTick(function() {
          let container = this.$refs.chatbox;
          container.scrollTop = container.scrollHeight + 10;
        })
      },
      disconnected() {
        this.$cable.perform({
          channel: "ChatChannel",
          action: "disconnect",
          data: {
            name: this.name
          }

        }) 

      },
    },
  },

  methods: {
     speak(){
      this.$cable.perform({
        channel: "ChatChannel",
        action: "speak",
        data: {
          message: this.input_message,
          name: this.name,
        },
      });
      this.input_message = ''

     }
   }

 }

</script>

<style>
*{
  box-sizing:border-box;
}
body{
 
  font-family:Arial;
}
.scrollable {
  overflow: hidden;
  overflow-y: scroll;
  height: calc(100vh - 20px);
}
#container{
  /* width:750px; */
  width:490px;
  height:600px;
  background:#eff3f7;
  margin:0 auto;
  font-size:0;
  border-radius:5px;
  overflow:hidden;
}
/* aside{
  width:260px;
  height:800px;
  background-color:#3b3e49;
  display:inline-block;
  font-size:15px;
  vertical-align:top;
} */
main{
  width:490px;
  height:600px;
  display:inline-block;
  font-size:15px;
  vertical-align:top;
}

/* aside header{
  padding:30px 20px;
}
aside input{
  width:100%;
  height:50px;
  line-height:50px;
  padding:0 50px 0 20px;
  background-color:#5e616a;
  border:none;
  border-radius:3px;
  color:#fff;
  background-image:url(https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/ico_search.png);
  background-repeat:no-repeat;
  background-position:170px;
  background-size:40px;
}
aside input::placeholder{
  color:#fff;
}
aside ul{
  padding-left:0;
  margin:0;
  list-style-type:none;
  overflow-y:scroll;
  height:690px;
}
aside li{
  padding:10px 0;
}
aside li:hover{
  background-color:#5e616a;
} */
h2,h3{
  margin:0;
}
/* aside li img{
  border-radius:50%;
  margin-left:20px;
  margin-right:8px;
}
aside li div{
  display:inline-block;
  vertical-align:top;
  margin-top:12px;
}
aside li h2{
  font-size:14px;
  color:#fff;
  font-weight:normal;
  margin-bottom:5px;
}
aside li h3{
  font-size:12px;
  color:#7e818a;
  font-weight:normal;
} */

.status{
  width:8px;
  height:8px;
  border-radius:50%;
  display:inline-block;
  margin-right:7px;
}
.green{
  background-color:#58b666;
}
.orange{
  background-color:#ff725d;
}
.blue{
  background-color:#6fbced;
  margin-right:0;
  margin-left:7px;
}

main header{
  height:110px;
  padding:30px 20px 30px 40px;
}
main header > *{
  display:inline-block;
  vertical-align:top;
}
main header img:first-child{
  border-radius:50%;
}
main header img:last-child{
  width:24px;
  margin-top:8px;
}
main header div{
  margin-left:10px;
  margin-right:145px;
}
main header h2{
  font-size:16px;
  margin-bottom:5px;
}
main header h3{
  font-size:14px;
  font-weight:normal;
  color:#7e818a;
}

#chat{
  padding-left:0;
  margin:0;
  list-style-type:none;
  overflow-y:scroll;
  height:285px;
  border-top:2px solid #fff;
  border-bottom:2px solid #fff;
}
#chat li{
  padding:10px 30px;
}
#chat h2,#chat h3{
  display:inline-block;
  font-size:13px;
  font-weight:normal;
}
#chat h3{
  color:#bbb;
}
#chat .entete{
  margin-bottom:5px;
}
#chat .message{
  padding:20px;
  color:#fff;
  line-height:25px;
  max-width:90%;
  display:inline-block;
  text-align:left;
  border-radius:5px;
}
#chat .me{
  text-align:right;
}
#chat .you .message{
  background-color:#58b666;
}
#chat .me .message{
  background-color:#6fbced;
}
#chat .triangle{
  width: 0;
  height: 0;
  border-style: solid;
  border-width: 0 10px 10px 10px;
}
#chat .you .triangle{
    border-color: transparent transparent #58b666 transparent;
    margin-left:15px;
}
#chat .me .triangle{
    border-color: transparent transparent #6fbced transparent;
    margin-left:375px;
}

main footer{
  height:155px;
  padding:20px 30px 10px 20px;
}
main footer textarea{
  resize:none;
  border:none;
  display:block;
  width:100%;
  height:80px;
  border-radius:3px;
  padding:20px;
  font-size:13px;
  margin-bottom:13px;
}
main footer textarea::placeholder{
  color:#ddd;
}
main footer img{
  height:30px;
  cursor:pointer;
}
main footer a{
  text-decoration:none;
  text-transform:uppercase;
  font-weight:bold;
  color:#6fbced;
  vertical-align:top;
  margin-left:333px;
  margin-top:5px;
  display:inline-block;
}

</style>