
<template>
  <main class="container">
    <nav >
      <ul>
        <li><strong>RORlab</strong></li>
      </ul>
      <ul>
        <li><a href="#">Link</a></li>
        <li><a href="#">Link</a></li>
        <li><a href="#" role="button">Button</a></li>
      </ul>
    </nav>
    
    <div class="grid">
      <div>
        <a href="#" role="button" class="outline" @click="form_blog( mode==null ? 'new' : null )">{{ mode==null ? "새로작성" : "취소" }}</a>
        <article v-if="mode=='new'" >
          <Form :blog="blog" :mode="mode" @submit="submit" />
        </article>

        <article v-for="(b, i) in blogs" :key="i" style="padding-top:0px"> 
          <nav class="container-fluid">
            <ul>
              <li> {{ b.id }}. {{ b.title }}   </li>
            </ul>
            <ul>
              <li> <a href="#" @click="form_blog(mode==null ? 'edit' : null, b, i)" ><small>{{ mode=="edit" && edit_index=='edit_'+i ? "취소" : "수정"  }}</small></a> </li>
              <li> <a href="#" @click="delete_blog(b.id)"><small>삭제</small></a></li>
            </ul>
          </nav>
          <hr />
          <div v-if="mode=='edit' && edit_index=='edit_'+i" >
            <Form :blog="b" :mode="mode" @submit="submit" />
          </div>
          <div style="padding-left: 20px; white-space:pre"  v-else > {{ b.content }} </div>
        </article>
      </div>
    </div>
  </main>
</template>

<script >
import Form from "./shared/components/form.vue"

export default {
  data() {
    return {
      msg: "Hello World Vue3!!",
      blogs: [],
      mode: null,
      blog: { title: '', content: ''},
      edit_index: null
    }
  },
  created(){
    this.get_blogs()
  },

  computed: {
    header(){
      return {common: {'X-CSRF-Token':  document.querySelector('meta[name="csrf-token"]').getAttribute('content'),'Content-Type': 'application/json'}}
    }
  },

  methods: {
    get_blogs(){
      this.$axios.get('/api/main?test=mytest',{headers: this.header}).then(response => {   
        console.log(response);   
        this.blogs = response.data.blogs;
      })  
    },

    form_blog(mode, blog, index){
      this.mode = mode
      if(mode=='new'){
        this.blog = { title: '', content: ''}
      }else if(mode=='edit'){
        this.blog = blog
        this.edit_index = mode==null ? null : 'edit_'+index
      }
    },
    
    submit(blog){
      console.log(this.header);
      this.$axios[this.mode=="new"?"post":"put"](`/api/main/${this.mode=='new' ? '' : blog.id }`,blog, {headers: this.header})
      .then(response => {   
        console.log(response);   
        this.blogs = response.data.blogs;
        this.mode = null
      })  
    },

    delete_blog(blog_id){
      const con = confirm("정맗 삭제 하시겠습니까?")
      if(con){
        this.$axios.delete(`/api/main/${blog_id}`, {headers: this.header})
        .then(response=>{
          this.blogs = response.data.blogs;
        })
      }
    }

  },

  components: {
    Form,
  }

}
</script> 