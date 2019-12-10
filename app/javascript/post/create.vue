<template>
    <div class="create-post row">
        <div class="col-md-6 offset-md-3">
            <div class="form-group">
                <label for="title">Title</label>
                <input type="title" class="form-control" id="title" v-model="title">
            </div>
     
            <div class="form-group">
                <label for="body">Body</label>
                <textarea class="form-control" id="body" name="body" rows="3" v-model="body"></textarea>
            </div>
            <div class="form-group">
                <a class="btn btn-block text-white btn-primary btn-lg">Create Post</a>
            </div>
        </div>
   </div>
</template>

<script>
import axios from 'axios';

export default {
    data: function () {
        return {
            title:null,
            body:null
        }
    },

    methods: {
        createPost() {

            axios.post('/api/post/create', {'title':this.title, 'body': this.body})
                .then((res) => {
                    //redirect back to home
                })
                .catch((err) => console.error(err));
        }
   },
}
</script>

