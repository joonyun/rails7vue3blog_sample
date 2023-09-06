<template>
  <div>
    <label for="title">
      Title
      <input type="text"  name="title" placeholder="title" v-model="blog.title" required>
    </label>
    <label for="content">
      Content
      <textarea  name="content" v-model="blog.content" />
    </label>
    <button type="submit" @click="$emit('submit', blog)">Submit</button>
  </div>
</template>

<script >
 export default {
    props: ["blog", "mode"],
    
 }


</script>