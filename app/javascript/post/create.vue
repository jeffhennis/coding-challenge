<template>
    <div class="create-post row">
        <div class="col-md-6 offset-md-3">
            <div class="form-group"  v-bind:class="{ 'has-error': errors.title }">
                <label for="title">Title</label>
                <input type="title" class="form-control" id="title" v-model="title">
                <div class="error-message" v-if="errors.title">
                    {{errors.title[0]}}
                </div>
            </div>
        
            <div class="form-group" v-bind:class="{ 'has-error': errors.body }">
                <label for="body">Body</label>
                <textarea class="form-control" id="body" name="body" rows="3" v-model="body"></textarea>
                <div class="error-message" v-if="errors.body">
                    {{errors.body[0]}}
                  </div>
            </div>
            <div class="form-group">
                <a class="btn btn-block text-white btn-primary btn-lg" @click.prevent="createPost">Create Post</a>
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
            body:null,
            errors: []
        }
    },

    methods: {
        createPost() {

            axios.post('/api/post/create', {'title':this.title, 'body': this.body})
                .then((res) => {
                    if(res.data.success){
                        window.location.href = "/posts";
                    } 

                    if(res.data.success == false){
                        this.errors = res.data.errors;
                    }
                })
                .catch((err) => console.error(err));
        }
   },
}
</script>