<template>
    <div class="show-post">
        <div class="post" v-if="post">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <h3>{{post.title}}</h3>
                    <p>{{post.body}}</p>

                    <div class="text-right">
                        <a href="#" class="btn btn-danger" @click.prevent="deletePost">Delete Post</a>
                    </div>
                

                    <hr>
                    <h4>Comments</h4>
                    <div class="add-comment">
                        <div class="form-group" v-bind:class="{ 'has-error': errors.comment }">
                            <textarea class="form-control" id="comment" name="comment" rows="2" v-model="comment" placeholder="Add Comment"></textarea>
                            <div class="error-message" v-if="errors.comment">
                                {{errors.comment[0]}}
                            </div>
                        </div>
                        <div class="form-group">
                            <a class="btn btn-block text-white btn-primary" @click.prevent="createComment">Post Comment</a>
                        </div>
                    </div>
                    <div class="comments">
                        <div class="comment" v-for="c in comments">
                            <div class="edit-comment" v-if="c.id == comment_edit">
                                <div class="form-group" v-bind:class="{ 'has-error': edit_errors.comment }">
                                    <textarea class="form-control" id="edit-comment" name="edit-comment" rows="2" v-model="comment_value" autofocus></textarea>
                                    <div class="error-message" v-if="edit_errors.comment">
                                        {{edit_errors.comment[0]}}
                                    </div>
                                </div>
                                <div class="text-right">
                                    <a href="#" class="btn btn-sm btn-primary" @click.prevent="updateComment">Update</a>
                                    <a href="#" class="btn btn-sm btn-secondary" @click.prevent="cancelEditComment">Cancel</a>
                                </div>
                                
                            </div>
                            <div v-else>
                                <p>{{c.comment}}</p>
                                <div class="text-right">
                                    <a href="#" class="btn btn-sm btn-secondary" @click.prevent="setEditComment(c.id, c.comment)">Edit</a>
                                    <a href="#" class="btn btn-sm btn-danger" @click.prevent="deleteComment(c.id)">Delete</a>
                                </div>
                            </div>
                            <hr>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <div div class="row" v-if="invalid">
            <div class="col-md-6 offset-md-3">
                 <div class="alert alert-warning" >
                    This post could not be found
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
            post: false,
            comments: [],
            invalid: false,
            comment: '',
            comment_edit: null,
            comment_value: '',
            errors:[],
            edit_errors: []
        }
    },

    props: ['id'],

    created(){
        this.getPost();
    },

    methods: {
        getPost() {
            axios.get('/api/post/show/'+this.id)
                .then((res) => {
                    if(res.data.success){
                       this.post = res.data.post
                       this.comments = res.data.comments
                    } else {
                        this.invalid = true;
                    }
                })
                .catch((err) => console.error(err));
        },

        deletePost() {
            if(confirm('Are you sure you want to delete this post?')){
                
                axios.delete('/api/post/delete/'+this.id)
                    .then((res) => {
                        if(res.data.success){
                            window.location.href = "/posts";
                        }
                    })
                    .catch((err) => console.error(err));
            }
        },

        createComment() {
            this.errors = [];
            axios.post('/api/post/comment/create', {'comment':this.comment, 'post_id': this.post.id})
                .then((res) => {
                    if(res.data.success){
                        this.errors = [];
                        this.comment = '';
                        this.comments = res.data.comments;
                    } 

                    if(res.data.success == false){
                        this.errors = res.data.errors;
                    }
                })
                .catch((err) => console.error(err));
        },

        deleteComment(id) {
            if(confirm('Are you sure you want to delete this comment?')){
                
                axios.delete('/api/post/comment/delete/' + this.post.id +'/'+id)
                    .then((res) => {
                        if(res.data.success){
                            this.comments = res.data.comments;
                        }
                    })
                    .catch((err) => console.error(err));
            }
        },

        setEditComment(id, comment){
            this.cancelEditComment();
            this.comment_value = comment;
            this.comment_edit = id;
        },

        cancelEditComment() {
            this.comment_value = '';
            this.comment_edit = null;
            this.edit_errors = [];
        },

        updateComment() {
            this.errors = [];
            axios.post('/api/post/comment/update/' + this.comment_edit, {'comment':this.comment_value, 'post_id': this.post.id})
                .then((res) => {
                    if(res.data.success){
                       this.cancelEditComment();
                        this.comments = res.data.comments;
                    } 

                    if(res.data.success == false){
                        this.edit_errors = res.data.errors;
                    }
                })
                .catch((err) => console.error(err));
        },
   },
}
</script>