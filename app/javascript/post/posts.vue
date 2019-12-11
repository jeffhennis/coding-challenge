<template>
    <div class="all-posts">
        <div class="row">
            <div class="offset-md-6 col-md-3 mb-3">
               <div class="input-group ">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fa fa-search"></i></span>
                  </div>
                  <input type="text" class="form-control" placeholder="search" v-model="search" @keyup.enter="doSearch"><br>
                </div>
                <em class="btn btn-link pull-right" @click="clearSearch" v-if="search_view">Clear Search Results</em>
            </div>
        </div>

        <div class="post" v-for="post in posts">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <h2 class="post-title">{{post.title}}</h2>
                    <p class="post-body">{{post.body}}</p>
                    <div class="text-right">
                        <a :href="'/post/' + post.id">Comments({{post.comments.length}})</a>
                    </div>
                    <hr>
                </div>
            </div>
        </div>

        <div v-if="posts.length==0 && !search_view">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <div class="alert alert-primary">
                        Please create your first post.
                    </div>
                </div>
            </div>
        </div>

        <div v-if="posts.length==0 && search_view">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <div class="alert alert-primary">
                        Your search has no results.
                    </div>
                </div>
            </div>
        </div>

    </div>
</template>

<script>
import axios from 'axios';

export default {
    data: function () {
        return {
            posts: [],
            search: '',
            search_view: false
        }
    },

    created(){
        this.getPosts();
    },

    methods: {
        getPosts() {

            axios.get('/api/post/all')
                .then((res) => {
                    this.posts = res.data
                })
                .catch((err) => console.error(err));
        },

        doSearch() {
            if(this.search == ''){
                clearSearch();
                return;
            } 

            axios.post('/api/post/search', {'search' : this.search})
                .then((res) => {
                    this.search_view = true;
                    this.posts = res.data
                })
                .catch((err) => console.error(err));
        },

        clearSearch() {
            this.getPosts();
            this.search = '';
            this.search_view = false;
        }
   },
}
</script>